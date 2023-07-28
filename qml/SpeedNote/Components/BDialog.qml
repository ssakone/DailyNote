import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQ
import SpeedNote.Theme as Theme
import Qaterial as Qaterial

QQ.Popup {
    id: popup
    width: 280
    dim: true
    padding: 24

    property string title: ''
    property string message: ''
    property bool alignCenter: true
    property alias icon: _icon.icon
    property alias content: _column.children
    property alias dialogButtons: _row.children

    background: Qaterial.Card {
        leftInset: 0
        rightInset: 0
        topInset: 0
        bottomInset: 0
        radius: 28
        elevation: 3
        Rectangle {
            anchors.fill: parent
            radius: 28
            color: Qaterial.Colors.teal50
        }
    }
    Column {
        width: parent.width
        Qaterial.Icon {
            id: _icon
            icon: ''
            visible: icon.toString() !== ''
            width: 24
            height: 24
            anchors.horizontalCenter: alignCenter ? parent.horizontalCenter : undefined
        }

        Item {
            height: 16; width: 1
            visible: _icon.visible
        }

        TextLabel {
            text: popup.title
            width: parent.width - parent.padding * 2
            horizontalAlignment: alignCenter ? Text.AlignHCenter : Text.AlignLeft
            wrapMode: Text.Wrap
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {
            height: 16; width: 1
        }

        TextLabel {
            text: popup.message
            font.pixelSize: 14
            width: parent.width - parent.padding * 2
            horizontalAlignment: alignCenter ? Text.AlignHCenter : Text.AlignLeft
            wrapMode: Text.Wrap
            visible: text !== ''
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            id: _column
            width: parent.width - parent.padding * 2
        }

        Item {
            height: 24; width: 1
        }

        Row {
            id: _row
            anchors.right: parent.right

        }
    }

    anchors.centerIn: parent
}
