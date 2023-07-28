import QtQuick
import QtQuick.LocalStorage

ListModel {
    id: control

    enum Status {
        Loading,
        Ready,
        Error
    }

    signal fetched()
    signal removed(var id)
    signal created(var id)
    signal updated(var id)
    signal ready()

    property variant beforeCreate
    property variant beforeCreates
    property variant beforeDelete
    property variant beforeUpdate


    property string dbName: application_setting.user_business_name + '00'
    property string dbVersion: "1.0"
    property var db

    property string tableName: ""
    property var column

    property bool auto_fetch_data: true
    property bool skip_configuration: false

    property string __query__fetch__: 'SELECT * FROM %1'.arg(tableName)
    property string __query__get__: 'SELECT * FROM %1 WHERE id=%2'.arg(tableName)
    property string __query__get__where__: 'SELECT * FROM %1 WHERE %2'.arg(tableName)
    property string __query__create__: 'INSERT INTO %1(%2) VALUES(%3)'
    property string __query__update__: 'UPDATE %1 SET %2 WHERE id = %3'

    property bool debug: false
    property int status: StorageModel.Status.Loading



    onReady: {
        status = StorageModel.Status.Ready
    }
    Component.onCompleted: prepare()

    function logQuery(query) {
        if(debug)
            console.log("[SQL_COMMAND] %1".arg(query))
        return query
    }

    function sqlCreate(data){
        if (beforeCreate !== undefined) {
            data = control.beforeCreate(data)
        }
        return new Promise(function(resolve, reject){
            let column = [], value = [], column_str = '', completer = ''
            for(let col in data) { column.push(col) }
            column_str = column.join(',')
            column.map(col => value.push(data[col]))
            completer = "?,".repeat(column.length).slice(0, -1)

            control.db.transaction(
                function(tx) {
                    var rs = tx.executeSql(logQuery(__query__create__
                                           .arg(control.tableName)
                                           .arg(column_str)
                                           .arg(completer)), value);
                    data['id'] = parseInt(rs.insertId)
                    control.append(data)
                    created(data.id)
                    resolve(data)
                }
            )
        })
    }
    function sqlUpdate(id, data, index = false) {
        return new Promise(function(resolve, reject){
            control.db.transaction(
                function(tx) {
                    let values = "", column = []
                    for (var i in data) {
                        if(typeof(data[i])==="string"){
                            column.push("%1 = '%2'".arg(i).arg(data[i]))
                        }else {
                            column.push("%1 = %2".arg(i).arg(data[i]))
                        }
                    }
                    values = column.join(',')
                    let query = logQuery(__query__update__
                                .arg(control.tableName)
                                .arg(values)
                                .arg(index === true ? control.get(id).id : id))
                    tx.executeSql(query)
                    updated(id)
                    resolve()
                }
            )
        })
    }
    function sqlDelete(id, index = false) {
        return new Promise(function(resolve, reject){
            control.db.transaction(
                function(tx) {
                    let query;
                    if (index) {
                        query = 'DELETE FROM %1 WHERE id = %2'.arg(control.tableName).arg(control.get(id).id);
                    } else {
                        query = 'DELETE FROM %1 WHERE id= %2'.arg(control.tableName).arg(id)
                    }
                    tx.executeSql(logQuery(query));
                    removed(id)
                    resolve(id)
                }
            )
        })
    }
    function sqlQuery(query) {
        return new Promise(function(resolve, reject){
            control.db.transaction(
                function(tx) {
                    resolve(tx.executeSql(logQuery(query)));
                }
            )
        })
    }
    function sqlGet(id) {
        return new Promise(function(resolve, reject) {
            db.transaction(
                function(tx) {
                    var rs = tx.executeSql(logQuery(__query__get__.arg(id)));
                    if(rs.rows.length > 0) {
                        resolve(rs.rows.item(0))
                    } else {
                        resolve({})
                    }
                }
            )
        })
    }
    function sqlGetWhere(data) {
        return new Promise(function(resolve, reject) {
            db.transaction(
                function(tx) {
                    let values = "", column = []
                    for (var i in data) {
                        if(typeof(data[i])==="string"){
                            column.push("%1 = '%2'".arg(i).arg(data[i]))
                        }else {
                            column.push("%1 = %2".arg(i).arg(data[i]))
                        }
                    }
                    values = column.join(' and ')
                    let query = logQuery(__query__get__where__
                                .arg(values))
                    var rs = tx.executeSql(query);
                    resolve(rs.rows)
                }
            )
        })
    }

    function getObject(id) {
        return new Promise(function(resolve, reject) {
            sqlGet(id).then(function(data) {
                let obj = new _Object()
                Object.getOwnPropertyNames(data).forEach(function(_) {
                    Object.defineProperty(obj, _, {value: data[_]})
                })
                Object.defineProperty(obj, 'object', {value: find(function(model) { return model.id == id })})
                resolve(obj)
            })
        })
    }

    function fetch(query = control.__query__fetch__){
        return new Promise(function(resolve, reject) {
            db.transaction(
                function(tx) {
                    clear()
                    var rs = tx.executeSql(logQuery(query));
                    for (var i = 0; i < rs.rows.length; i++) {
                        if(debug) {
                            logQuery(JSON.stringify(rs.rows.item(i)))
                        }
                        control.append(rs.rows.item(i))
                    }
                    fetched()
                    resolve(true)
                }
            )
        })
    }

    function find(criteria) {
      for(var i = 0; i < control.count; ++i) if (criteria(control.get(i))) return control.get(i)
      return null
    }

    function findIndex(criteria) {
      for(var i = 0; i < control.count; ++i) if (criteria(control.get(i))) return i
      return null
    }

    function configure(){
        return new Promise(function(resolve, reject){
            control.db.transaction(
                function(tx) {
                    let query = "", columns = [], cols = []
                    control.column.forEach(function(info){
                        cols = []
                        cols.push("%1 %2".arg(info.name).arg(info.type === "BOOLEAN" ? "INTEGER" : info.type))
                        if("key" in info){
                            cols.push(info.key)
                        }
                        if("default" in info) {
                            if(info.type !== "INTEGER" && info.type !== "REAL"){
                                cols.push("DEFAULT '%1'".arg(info.def))
                            }
                            else if(info.type === "BOOLEAN") {
                                cols.push("DEFAULT %1".arg(info.def))
                            }
                            else {
                                cols.push("DEFAULT %1".arg(info.def))
                            }
                        }
                        columns.push(cols.join(' '))
                    })
                    query = "CREATE TABLE IF NOT EXISTS %1(%2)".arg(control.tableName).arg(columns.join(', '))
                    resolve(tx.executeSql(logQuery(query)))
                }
            )
        })
    }
    function prepare() {
        control.db = LocalStorage.openDatabaseSync(control.dbName, control.dbVersion)
        if(!control.skip_configuration){
            configure()
        }
        if(auto_fetch_data)
            fetch()

        ready()
    }

    property var _Object: class Object {
        remove() {
            let savedId = this.id
            control.sqlDelete(this.id).then(function(_) {
                let i = findIndex(function(e) { return e.id == savedId })
                control.remove(i)
                this.destroy()
            })
        }
    }

}
