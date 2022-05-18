pragma Singleton
import QtQuick

import SpeedNote.Providers as Pvs

Pvs.StorageModel {
    id: _model
    dbName: Database.name
    tableName: "NotesDB"
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
            name: "description",
            type: "TEXT",
            def: ""
        }
    ]

}
