import QtQuick
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls

Controls.BTabBar {
    id: searchBar
    leading.visible: false
    backgroundColor: Qaterial.Colors.teal50
    property string searchString
    Controls.TextField {
        Layout.preferredHeight: 50
        placeholderText: 'Recherche'
        placeholderTextColor: Qaterial.Colors.gray800
        background: Item {}
        anchors.fill: parent
        anchors.leftMargin: 40
        font.pixelSize: 18
        placeholderfont.pixelSize: 16
        placeholderfont.family: 'Roboto'
        inputMethodHints: Qt.ImhNoPredictiveText
        focus: true
        onPreeditTextChanged: searchBar.searchString = preeditText
        Component.onCompleted: forceActiveFocus()
    }
    Controls.BTabBarButton {
        x: 5
        opacity: .8
        icon.source: Qaterial.Icons.arrowLeft
        icon.color: Qaterial.Colors.black
        anchors.verticalCenter: parent.verticalCenter
        onClicked: searchBar.parent.view.pop()
    }
    Controls.BTabBarButton {
        anchors.right: parent.right
        anchors.rightMargin: 15
        visible: searchBar.searchString !== ''
        opacity: .8
        icon.source: Qaterial.Icons.close
        icon.color: Qaterial.Colors.black
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            parent.children[1].clear()
            parent.children[1].forceActiveFocus()
        }
    }
}
