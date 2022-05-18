import QtQuick
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import SpeedNote.Providers as Providers
import SpeedNote.Theme as Theme

import SpeedNote.Model as Model

import SpeedNote.Services


Controls.DR {
    id: _control
    signal clicked()
    width: 48
    height: 48
    property alias icon: _icon.icon
    Qaterial.AppBarButton {
        id: _icon
        width: 65
        height: 65
        icon.color: _control.parent.palette.text
        foregroundColor: _control.parent.palette.text
        anchors.centerIn: parent
        onClicked: _control.clicked()
    }
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
}
