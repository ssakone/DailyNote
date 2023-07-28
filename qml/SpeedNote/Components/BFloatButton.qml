import QtQuick
import QtQuick.Layouts

import Qaterial as Qaterial
import SpeedNote.Theme as Theme

Qaterial.FabButton {
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.rightMargin: 25
    anchors.bottomMargin: 25
    width: 60
    height: 60
    radius: 16
    elevation: 6
    icon.width: 24
    icon.height: 24
    backgroundColor: Theme.Style.accentColor
    foregroundColor: Theme.Style.accentTextColor
    HoverHandler {
        cursorShape: "PointingHandCursor"
    }
}
