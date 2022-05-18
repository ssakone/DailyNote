import QtQuick

import SpeedNote.Model as Model

Item {
    id: form

    Component.onCompleted: {
        datas = []
        getChilds(datas, form)
    }

    property var datas: []
    function formData() {
        let _formData = {}
        for(let i = 0; i < datas.length; i++) {
            let item = datas[i]
            _formData[item.name] = item.text
        }
        return _formData
    }

    function getChilds(datas, child) {
        if(child.objectName === 'form-input')
            return datas.push(child)

        if(child.children.length > 0) {
            Util.forEach(child.children, function(_child){
                getChilds(datas, _child)
            })
        }
    }

    function isValid() {
        let error = false
        for(let i = 0; i < datas.length; i++) {
            let item = datas[i]
            if(!item.isValid()) {
                error = true
            }
        }
        return !error
    }

    function clear() {
        Util.forEach(datas, function(input){
            input.clear()
        })
    }
}
