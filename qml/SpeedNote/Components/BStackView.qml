import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Providers as Providers
import SpeedNote.Theme as Theme
import SpeedNote.Model as Model
import SpeedNote.Pages
import SpeedNote.Services

StackView {
    id: m_view
    anchors.fill: parent
    pushEnter:  _transition_enter_default_page
    popExit: _transition_exit_default_page

    Transition {
        id: _transition_enter_default_page
        from: "*"
        to: "*"
        NumberAnimation {
            properties: "x"
            from: m_view.width
            to: 0
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    Transition {
        id: _transition_enter_search_page
        from: "*"
        to: "*"
        NumberAnimation {
            properties: "y"
            from: m_view.height
            to: 0
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    Transition {
        id: _transition_exit_default_page
        from: "*"
        to: "*"
        NumberAnimation {
            properties: "x"
            from: 0
            to: m_view.width
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    Transition {
        id: _transition_exit_search_page
        from: "*"
        to: "*"
        NumberAnimation {
            properties: "y"
            from: 0
            to: m_view.height
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: m_view.busy
    }
}
