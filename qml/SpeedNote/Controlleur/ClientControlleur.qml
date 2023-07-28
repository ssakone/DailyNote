import QtQuick

import SpeedNote.Model as Model
import SpeedNote.Pages.Clients
import SpeedNote.Pages.Clients.SubPages

import SpeedNote.Services
BaseControlleur {

    property Component indexView: Client { }
    property Component addView: ClientAdd { }
    property Component editView: ClientEdit { }
    property Component detailsView: ClientView { }


    function all(model) {
        Model.Client.fetch();
    }

    function create(formData) {
        return new Promise(function(resolve, reject){
            Model.Client.sqlCreate(formData).then(function (rs) {
                resolve(rs)
            })
        })
    }
}
