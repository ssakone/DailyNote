import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qaterial as Qaterial

import SpeedNote.Theme as Theme

Rectangle {
    id: control
    height: width
    radius: 21

    property bool disabled: false
    property color backgroundColor: Qaterial.Colors.gray200

    color: area.containsMouse ? hightLightBackgroundColor : backgroundColor
    property string text:''// _inside_label.text
    property alias icon: _inside_label.icon
    property alias label: _inside_label
    signal clicked()
    signal tapped()

    opacity: disabled ? .4 : 1

    property color hightLightBackgroundColor: Theme.Style.primaryColor
    Column  {
        anchors.centerIn: parent
        spacing: 15
        Qaterial.IconLabel {
            id: _inside_label
            icon.source: ""
            icon.color: area.containsMouse ? Qaterial.Style.foregroundColorDark : 'transparent'
            color: !area.containsMouse ? Qaterial.Style.foregroundColorDark : Qaterial.Style.foregroundColor
            icon.width: (control.width / 4)
            icon.height: icon.width
            spacing: 16
            anchors.horizontalCenter: parent.horizontalCenter
            text: ''
            display: Qaterial.IconLabel.IconOnly
            wrapMode: Qaterial.Label.Wrap
            width: (control.width / 2) + 40
            horizontalAlignment: Qaterial.IconLabel.AlignHCenter
            font.family: 'Montserrat'
            font.weight: area.containsMouse ? Font.Medium : Font.Normal
            font.pixelSize: (control.width / 11)
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Qaterial.Label.Wrap
            color: area.containsMouse ? Qaterial.Style.foregroundColorDark : Qaterial.Style.foregroundColor
            horizontalAlignment: Qaterial.IconLabel.AlignHCenter
            text: control.text
            font: _inside_label.font
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: disabled ? false : true
        cursorShape: "PointingHandCursor"
        onClicked: control.clicked()
    }
    TapHandler {
        cursorShape: "PointingHandCursor"
        onTapped: control.tapped()
    }

}
