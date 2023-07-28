import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import Watcher

import Utils

import QuickFlux

ApplicationWindow {

    id: window
    property string server: "http://%1:8000".arg(hot_reload_server_ip ?? "localhost")
    property bool connectedToReloader: false

    color: Qaterial.Colors.gray200
    title: 'SpeedNote'
    visible: true
    height: 882
    width: Qt.platform.os === "android" ? 400 : 1000

    Loader {
        id: loader
        width: parent.width
        height: parent.height
        source: getPath() + "?q="+Math.random()
        onStatusChanged: {
            if(status === Loader.Ready) {
                connectedToReloader = true
            }
        }

        function reload() {
            Watcher.clearCache();
            source = getPath() + "?q="+Math.random()
        }

        BusyIndicator {
            anchors.centerIn: parent
            running: Loader.Loading == loader.status
        }
    }

    function getPath() {
        if(devMode ?? false) {
          return "%1/qml/SpeedNote/hot_main.qml".arg(server)
        } else {
            switch(Qt.platform.os) {
            case "windows":
                return  "file:///E:/PRIMARY/ME/SpeedNote/qml/SpeedNote/hot_main.qml"
            case "linux":
                return "qrc:/qml/SpeedNote/hot_main.qml"
            case "android":
                return "qrc:/qml/SpeedNote/hot_main.qml"
            }
        }
    }
}

