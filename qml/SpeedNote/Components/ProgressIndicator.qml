import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qaterial as Qaterial
import "../Components/"

Row {
    spacing: 10
    property int progres: 0
    Label {
        font.family: 'Montserrat'
        font.weight: Font.Medium
        visible:  progres == 0
        font.pixelSize: 18
        color: Qaterial.Style.accentColor
        text: 'Semaines'
    }


    Label {
        font.family: 'Montserrat'
        visible:  progres == 1
        font.pixelSize: 18
        color: progres >= 1 ? Qaterial.Style.accentColor : Qaterial.Style.colorTheme.secondaryText
        text: 'Jour'
    }

    Label {
        font.family: 'Montserrat'
        visible:  progres == 2
        font.pixelSize: 18
        color: progres >= 2 ? Qaterial.Style.accentColor : Qaterial.Style.colorTheme.secondaryText
        text: 'Ouvriers'
    }
}
