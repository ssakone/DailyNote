import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Providers as Providers
import SpeedNote.Components as Controls
import SpeedNote.Theme as Theme

Qaterial.ToolBar {
    id: _control
    property string title
    property string subTitle
    property alias actions: _actions.children
    property alias leading: _leading
    property alias titleLabel: _title
    property string foregroundColor: palette.text
    property int flexibleHeight: 0
    height: 64
    backgroundColor: 'transparent'// palette.base
    elevation: 0
    palette.base: Theme.Style.surfaceVariantColor
    palette.text: Theme.Style.surfaceVariantTextColor
    Item {
        width: _control.width
        height: 64
        z: 99
        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            anchors.leftMargin: 6
            spacing: 24 - 17
            Controls.BTabBarButton {
                id: _leading
                icon.source: Qaterial.Icons.arrowLeft
                icon.color: _control.palette.text
                onClicked: _control.parent.StackView.view.pop()
            }
            Controls.DR {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                Controls.TextLabel {
                    id: _title
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width
                    font.pixelSize: 22
                    font.family: 'Roboto'
                    font.weight: Font.Medium
                    font.letterSpacing: 0.55
                    color: _control.palette.text
                    text: _control.title
                }
            }
            Flow {
                id: _actions
                Layout.preferredHeight: 40
                Layout.maximumHeight: 40
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}
