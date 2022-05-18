import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qaterial as Qaterial


Qaterial.ComboBox {
    property color backgroundColor: Qaterial.Colors.gray100

    id: _function_field
    height: 60
    rightPadding: 24
    font.pixelSize: 18

    indicator: ColorImage
    {
      x: (_function_field.mirrored ? _function_field.padding : _function_field.width - width - _function_field.padding) - 10
      y: _function_field.topPadding + (_function_field.availableHeight - height) / 2
      color: _function_field.enabled ? _function_field.Material.foreground : _function_field.Material.hintTextColor
      source: Qaterial.Icons.menuDown
    } // ColorImage

    background: Rectangle {
        color: _function_field.backgroundColor
        radius: 8
    }
}
