import QtQuick
import QtQuick.Layouts
import SpeedNote.Theme as Theme
import Qaterial as Qaterial

Qaterial.FabButton {
    id: _control
    backgroundColor: _control.hovered ? Qt.darker(Theme.Style.accentColor) : Theme.Style.accentColor
    foregroundColor: _control.hovered ? Qt.lighter(Theme.Style.accentColor) : Theme.Style.accentTextColor
    topInset: 0
    bottomInset: 0
    elevation: 0
    leftPadding: 10
    rightPadding: 10
    display: BButton.TextOnly
    contentItem: Qaterial.IconLabel
    {
      id: _iconLabel
      spacing: _control.spacing
      display: _control.display
      icon.source: _control.icon.source
      icon.width: _control.icon.width
      icon.height: _control.icon.height
      text: _control.text
      font: _control.font
      color: _control.foregroundColor
      elide: Qaterial.Label.ElideRight
    }
    font {
        family: 'Roboto'
        weight: Font.Medium
        pixelSize: 14
    }

}
