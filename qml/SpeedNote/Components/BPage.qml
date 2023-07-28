import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Providers as Providers
import SpeedNote.Components as Controls
import SpeedNote.Theme as Theme

Qaterial.Page {
    id: _pageControl
    property bool transparentBackground: false
    property var view: StackView.view ?? undefined
    property color foregroundcolor: Theme.Style.backgroundTextColor

    palette.base: Theme.Style.backgroundColor
    palette.text: Theme.Style.backgroundTextColor

    header: BTabBar {
        id: _toolBarControl
        title: _pageControl.title
        width: _pageControl.width
    }

    background: Rectangle {
        color: _pageControl.transparentBackground ? 'transparent' : Theme.Style.backgroundColor
    }

    topPadding: 5
}
