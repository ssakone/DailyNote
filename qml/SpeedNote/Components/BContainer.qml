import QtQuick
import QtQuick.Layouts
import Qaterial.GraphicalEffects
import SpeedNote.Theme as Theme
import Qaterial as Qaterial

Rectangle {
    id: _control
    palette.base: Theme.Style.secondaryContainerColor
    palette.text: Theme.Style.secondaryContainerTextColor
    color: 'transparent' //palette.base
    border.color: Qaterial.Colors.gray300
    border.width: 2
    radius: 8
}
