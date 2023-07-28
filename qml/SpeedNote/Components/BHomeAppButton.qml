import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qaterial as Qaterial
import SpeedNote.Theme as Theme
Rectangle {
    id: control
    height: width
    radius: 13

    property bool disabled: false
    property color backgroundColor: Qaterial.Colors.gray100
    property color foregroundColor: Theme.Style.primaryTextColor

    color: area.containsMouse ? hightLightBackgroundColor : backgroundColor
    property string text:''
    property alias icon: _inside_label.icon
    property alias label: _inside_label
    signal clicked()
    signal tapped()

    opacity: disabled ? .4 : 1

    property color hightLightBackgroundColor: Theme.Style.secondaryColor
    Column  {
        anchors.centerIn: parent
        spacing: 4
        Qaterial.IconLabel {
            id: _inside_label
            icon.source: ""
            icon.color: area.containsMouse ? Theme.Style.primaryTextColor : control.foregroundColor
            icon.width: control.width / 2.7
            icon.height: icon.width
            spacing: 16
            anchors.horizontalCenter: parent.horizontalCenter
            text: ''
            display: Qaterial.IconLabel.IconOnly
            wrapMode: Qaterial.Label.Wrap
            width: (control.width / 2) + 40
            horizontalAlignment: Qaterial.IconLabel.AlignHCenter
            font.family: 'Montserrat'
            font.weight: Font.DemiBold
            font.pixelSize: control.width / 8.5
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Qaterial.Label.Wrap
            width: parent.width - 10
            color: _inside_label.icon.color
            horizontalAlignment: Text.AlignHCenter
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
