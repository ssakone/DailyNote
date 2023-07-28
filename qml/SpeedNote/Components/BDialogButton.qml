import QtQuick
import SpeedNote.Theme as Theme
import Qaterial as Qaterial

Qaterial.FlatButton {
    text: ''
    leftInset: 0
    bottomInset: 0
    rightInset: 0
    topInset: 0
    height: 40
    leftPadding: 12
    rightPadding: 12
    font {
        family: 'Roboto'
        weight: Font.Medium
        pixelSize: 14
    }

    foregroundColor: Theme.Style.accentColor
}
