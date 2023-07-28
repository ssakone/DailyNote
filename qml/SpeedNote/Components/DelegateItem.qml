import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qaterial as Qaterial

Rectangle {
    id: control
    height: 60
    radius: 18

    property bool disabled: false

    color: area.containsMouse ? hightLightBackgroundColor : Qaterial.Style.backgroundColor
    property string text:''// _inside_label.text
    signal clicked()
    signal tapped()

    opacity: disabled ? .4 : 1

    property color hightLightBackgroundColor: Qaterial.Style.accentColor
    TextLabel {
        leftPadding: 14
        anchors.verticalCenter: parent.verticalCenter
        wrapMode: Qaterial.Label.Wrap
        color: area.containsMouse ? Qaterial.Style.foregroundColorDark : Qaterial.Style.foregroundColor
        horizontalAlignment: Qaterial.IconLabel.AlignLeft
        text: control.text
        font.pixelSize: 13
        font.weight: Font.Light
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
