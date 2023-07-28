pragma Singleton
import QtQuick

import SpeedNote.Providers as Pvs

Pvs.StorageModel {
    id: _model
    dbName: Database.name
    tableName: "NotesDB"
    debug: true
    column: [
        {
            name: "id",
            type: "INTEGER",
            key: "PRIMARY KEY"
        },
        {
            name: "label",
            type: "TEXT"
        },
        {
            name: "uuid",
            type: "TEXT"
        },
        {
            name: "description",
            type: "TEXT",
            def: ""
        },
        {
            name: "status",
            type: "INTEGER",
            def: 0
        },
        {
            name: "created_at",
            type: "REAL"
        },
        {
            name: "updated_at",
            type: "REAL"
        }
    ]
    beforeCreate: function(data) {
        data["created_at"] = new Date().getTime()
        data["updated_at"] = data["created_at"]
        data["uuid"] = 'dsd' + Math.random()
        return data;
    }
}
