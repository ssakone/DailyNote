import QtQuick
import QtQuick.Layouts

import Qaterial as Qaterial
import SpeedNote.Theme as Theme

Qaterial.FabButton {
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.rightMargin: 20
    anchors.bottomMargin: 20
    width: 70
    height: 70
    radius: 16
    elevation: 6
    icon.width: 36
    icon.height: 36
    backgroundColor: Theme.Style.accentColor
    foregroundColor: Theme.Style.accentTextColor
}
