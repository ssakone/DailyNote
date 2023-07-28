import QtQuick
import QtQuick.Controls as QQ
import QtQuick.Controls.Material
import QtQuick.Layouts

import QuickFlux

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import SpeedNote.Providers as Providers
import SpeedNote.Model as Model
import SpeedNote.Theme as Theme
import SpeedNote.Services

Component {
    Controls.BPage {
        id: rootPage
        topPadding: 0
        transparentBackground: false
        
        header.visible: false
        background: Rectangle {
            color: 'white'
        }

        component ApplicationButton: Controls.BHomeAppButton {
            height: width
            width: 120
            foregroundColor: Qaterial.Colors.black
            backgroundColor: Qaterial.Colors.gray100
        }

        component ApplicationTabButton: Item {
            property string iconSource
            property string iconText
            property int index
            Layout.fillHeight: true
            Layout.fillWidth: true
            Qaterial.SquareButton {
                font.pixelSize: 14
                bottomInset: 0
                leftInset: 0
                rightInset: 0
                topPadding: 0
                topInset: 0
                radius: 0
                rippleColor: 'transparent'
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                onClicked: tabBar.currentIndex = index
                Column {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 5
                    spacing: 4
                    Rectangle {
                        width: parent.parent.width / 3
                        height: 32
                        radius: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: tabBar.currentIndex === index ? Qaterial.Colors.teal100 : 'transparent'
                        Qaterial.Icon {
                            opacity: tabBar.currentIndex === index ? 1 : .5
                            icon: iconSource
                            size: 24
                            anchors.centerIn: parent
                        }
                    }

                    Controls.TextLabel {
                        text: iconText
                        font.pixelSize: 12
                        font.weight: tabBar.currentIndex === index ? Font.Medium : Font.Normal
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }


        component ApplicationSettingsItem: Controls.BItemDelegate {
            property alias label: _insideText.text
            leftPadding: 20
            rightPadding: 20
            width: parent.width
            height: 65
            onClicked: view.push(account_settings)
            roundColor: 'transparent'
            //iconColor: Qaterial.Colors.purple600
            icon.source: Qaterial.Icons.accountCircleOutline
            Controls.TextLabel {
                id: _insideText
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -5
                x: 75
                font.family: 'Roboto'
                font.weight: Font.Normal
                font.pixelSize: 18
                font.letterSpacing: 0.15
                text: parent.text
            }
        }

        ColumnLayout {
            spacing: 2
            anchors.fill: parent
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            StackView {
                id: view
                Layout.fillHeight: true
                Layout.fillWidth: true
                initialItem: noteList

                Connections {
                    target: window
                    function onClosing(event) {
                        if(view.depth > 1) {
                            event.accepted = false
                            view.pop()
                        }
                    }
                }
            }
        }

        AppListener {
            filter: ActionTypes.navigateTo
            onDispatched: function(message) {
                console.log('dispatcher send this ==> ',message)
            }
        }

        MiddlewareList {
            applyTarget: AppAction

            NoteMiddleware {
                stack: view
            }
        }


        NewNote {
            id: newNote
        }
        NoteList {
            id: noteList
        }

        NoteView {
            id: noteView
        }
    }
}
