import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import SpeedNote.Providers as Providers
import SpeedNote.Theme as Theme
import SpeedNote.AndroidTheme
import SpeedNote.Model as Model
import SpeedNote.Pages
import SpeedNote.Services

import QtCore

import Watcher

Item {
    id: root

    Settings {
        id: application_setting
    }

    AndroidTheme {
        id: androidTheme
        statusColor: Qaterial.Colors.gray50
        navigationColor: Qaterial.Colors.teal50
        theme: 2
    }

    Providers.FontProvider {
        id: font_provider
    }

    Qaterial.DepthStackView {
        id: m_view
        anchors.fill: parent
        initialItem: m_home
    }

    Connections {
        target: window
        function onClosing(e) {
            if(m_view.depth > 1) {
                m_view.pop()
                e.accepted = false
            } else {
                e.accepted = true
            }
        }
    }


    Home {
        id: m_home
    }

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: .05
        source: Providers.Icons.backgroundY
    }

    Component.onCompleted: {
        Theme.Style.theme = Theme.Style.Theme.Light
        Qaterial.Style.theme = Qaterial.Style.Theme.Light
        Qaterial.Style.accentColor = Theme.Style.primaryTextColor
        Qaterial.Style.primaryColor = Theme.Style.primaryColor
    }
}
