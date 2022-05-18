import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQ
import Qaterial as Qaterial

Qaterial.TextArea {
    id: _control
    backgroundColor:  Qaterial.Colors.gray100
    background: Rectangle {
        radius: 13
        color: _control.backgroundColor
    }
}
