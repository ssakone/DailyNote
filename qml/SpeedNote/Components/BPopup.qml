import QtQuick

import Qaterial as Qaterial

Qaterial.Popup {
    id: control
    width: 330
    height: 250
    dim: true
    modal: true
    anchors.centerIn: parent
    background: Rectangle {
        implicitWidth: Qaterial.Style.menu.implicitWidth
        implicitHeight: Qaterial.Style.menu.implicitHeight
        radius: 21
        color: control.backgroundColor
    }

}
