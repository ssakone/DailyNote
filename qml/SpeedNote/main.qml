import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import QtWebSockets

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import Watcher

import Utils

Qaterial.ApplicationWindow {

    id: window
    property string server: "http://%1:8000".arg(hot_reload_server_ip)
    property bool connectedToReloader: false

    color: Qaterial.Colors.gray200
    title: 'SpeedNote'
    visible: true
    height: 882
    width: 400

    Component.onCompleted: {
        console.log(Utils.writeFile('~/Temp/test.txt','Enokas is The King', false))
    }

    WebSocketServer {
        id: wsServer
        accept: true
        listen: true
        host: "0.0.0.0"
        port: 8001
        onClientConnected: function (webSocket) {
            connectedToReloader = true
            webSocket.onStatusChanged.connect(function(status){
                if(webSocket.status === WebSocket.Closed) {
                    connectedToReloader = false
                }
            })
            webSocket.textMessageReceived.connect(function(message){
                console.log(message)
                let data = JSON.parse(message)
                console.log(Object.keys(data))
                if(data.status === 0) {
                    console.log('new message:', data.message)
                } else if(data.status === 1) {
                    console.log('file change detected')
                    loader.reload()
                }
            })
        }
    }

    Loader {
        id: loader
        anchors.fill: parent
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

    header:  Qaterial.ToolBar {
        visible: devMode
        width: parent.width
        height: 60
        elevation: 0
        backgroundColor: connectedToReloader ? Qaterial.Colors.purple600 : Qaterial.Colors.red700
        Behavior on backgroundColor {
            ColorAnimation {
                duration: 200
            }
        }

        palette.text: 'white'
        RowLayout {
            anchors.fill: parent
            anchors.rightMargin: 10
            Label {
                Layout.alignment: Qt.AlignVCenter
                text: 'Developer Mode'
                leftPadding: 10
                font.pixelSize: 16
                color:'white'
                font.weight: Font.DemiBold
            }
            Item {
                Layout.fillWidth: true
            }
            Controls.BTabBarButton {
                icon.source: Qaterial.Icons.refresh
                onClicked: loader.reload()
            }
        }
    }

    function getPath() {
        if(devMode) {
          return "%1/qml/SpeedNote/hot_main.qml".arg(server)
        } else {
            switch(Qt.platform.os) {
            case "windows":
                return  "file:///E:/PRIMARY/01STUDIO/SpeedNote/qml/SpeedNote/hot_main.qml"
            case "linux":
                return "file:///home/enokas/Workstation/01STUDIO/SpeedNote/qml/SpeedNote/hot_main.qml"
            case "android":
                return "qrc:/qml/SpeedNote/hot_main.qml"
            }
        }
    }
}

