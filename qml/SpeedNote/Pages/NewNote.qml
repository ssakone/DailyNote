import QtQuick
import QtQuick.Controls as QQ
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import SpeedNote.Providers as Providers
import SpeedNote.Services

import SpeedNote.Model as Model

Qaterial.Popup {
    id: vente_item_details
    property int startY: 300
    property var currentItem
    property bool haveItem: currentItem !== undefined
    property int quantite: _quantite_field.text
    property int sell_price: haveItem ? parseInt(currentItem.sell_price) : 0
    property int montant: quantite * sell_price

    component TableRow: RowLayout {
        property string name
        property string value
        Controls.TextLabel {
            Layout.fillWidth: true
            font.pixelSize: 14
            font.weight: Font.Thin
            rightPadding: 10
            opacity: .7
            horizontalAlignment: Controls.TextLabel.AlignLeft
            text: name
        }

        Controls.TextLabel {
            Layout.fillWidth: true
            font.pixelSize: 18
            rightPadding: 10
            horizontalAlignment: Controls.TextLabel.AlignRight
            text: value
        }
    }

    Connections {
        target: vente_item_details
        function onCurrentItemChanged() {
            console.log('changed')
        }
    }

    onQuantiteChanged: {
        vente_page.calculate_total()
    }

    width: parent.width
    height: parent.height
    dim: true
    modal: true
    parent: QQ.Overlay.overlay
    onVisibleChanged: {
        if(!visible) {
            vente_item_details.destroy()
        }
    }

    enter: Transition {
        NumberAnimation {
            property: "y"
            from: vente_item_details.startY
            to: 0
            easing.type: Easing.InOutCirc
        }
        NumberAnimation {
            property: "height"
            from: 10
            to: vente_item_details.parent.height
            easing.type: Easing.InOutCirc
        }
    }
    exit: Transition {
        NumberAnimation {
            property: "y"
            from: 0
            to: vente_item_details.startY
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            property: "height"
            from: vente_item_details.parent.height
            to: 10
            easing.type: Easing.InOutCirc
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: 5
        visible: parent.height > 250
        enabled: parent.height > 250
        spacing: 10
        RowLayout {
            Layout.fillWidth: true
            Item {
                Layout.fillWidth: true

            }
            Controls.BTabBarButton {
                icon.source: Qaterial.Icons.close
                icon.color: Qaterial.Colors.black
                Layout.alignment: Qt.AlignTop
                onClicked: vente_item_details.close()
            }
        }

        Item {
            Layout.fillWidth: true
            Controls.TextField {
                id: _title
                width: parent.width
                x: -10
                wrapMode: Controls.TextLabel.Wrap
                anchors.verticalCenter: parent.verticalCenter
                placeholderText: 'Title ...'
                placeholderfont.pixelSize: 28
                placeholderfont.weight: Font.Normal
                background: Item {}
                font.pixelSize: 28
                font.weight: Font.Light
            }
        }

        Item {
            height: 20
            width: 10
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Controls.TextArea {
                id: _description
                anchors.fill: parent
                wrapMode: Controls.TextLabel.Wrap
                anchors.verticalCenter: parent.verticalCenter
                placeholderText: 'Description ...'
                background: Item {}
                font.pixelSize: 20
                font.weight: Font.Light
            }
        }
    }
}
