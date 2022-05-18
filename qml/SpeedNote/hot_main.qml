import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import SpeedNote.Providers as Providers
import SpeedNote.Theme as Theme
import SpeedNote.AndroidTheme
import SpeedNote.Model as Model
import SpeedNote.Pages
import SpeedNote.Services

import Qt.labs.settings

import Watcher

Item {
    id: root



    property var caisse: {
        total: 0
    }
    property var current_selected_depense: {
        total: 0
    }
    property int vente_total: 0
    property bool logged: true
    property bool debug: false
    property int currentStockId: 1

    anchors.fill: parent

    Settings {
        id: application_setting
        property alias logged: root.logged
        property alias current_stock_id: root.currentStockId
        property string user_first_name
        property string user_last_name
        property string user_business_name
        property int user_business_type
    }

    AndroidTheme {
        id: androidTheme
        statusColor: Qaterial.Colors.gray50
        navigationColor: Qaterial.Colors.teal50
        theme: 2
    }

    Providers.FontProvider {
        id: font_provider
        Component.onCompleted: {
            console.log(rR.name)
        }
    }

    Controls.BStackView {
        id: m_view
        enabled: root.logged
        visible: enabled
        initialItem: m_home
    }

    Connections {
        target: window
        function onClosing(e) {
            if(m_view.depth > 1) {
                m_view.pop()
                e.accepted = false
            } else {
                e.accepted = true
            }
        }
    }

    Connections {
        enabled: root.logged
        target: Model.Caisse
        function onUpdated() {
            loadCaisse()
        }
        function onCreated() {
            loadCaisse()
        }
    }

    Home {
        id: m_home
    }

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: root.logged ? 0.07 : .2
        source: Providers.Icons.backgroundY
    }

    Controls.BDialog {
        title: 'Basic dialog title'
        message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet venenatis purus.'
        alignCenter: false
        dialogButtons: [
            Controls.BDialogButton {
                text: 'Accepter'
            },
            Controls.BDialogButton {
                text: 'Accepter'
            }
        ]

    }


    Component.onCompleted: {
        Theme.Style.theme = Theme.Style.Theme.Light
        Qaterial.Style.theme = Qaterial.Style.Theme.Light
        Qaterial.Style.accentColor = Theme.Style.primaryTextColor
        Qaterial.Style.primaryColor = Theme.Style.primaryColor
    }
}
