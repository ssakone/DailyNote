import QtQuick
import QtQuick.Controls as QQ
import QtQuick.Controls.Material
import QtQuick.Layouts

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
            width: (parent.width - 30) / 3
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

        NewNote {
            id: newNote
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

        RowLayout {
            y: 10
            width: parent.width - 40
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter
            Item {
                Layout.fillWidth: true
                Controls.TextLabel {
                    text: 'SpeedNote ' + Application.version
                    font.pixelSize: 26
                    font.family: 'Montserrat'
                    font.weight: Font.Medium
                    color: Theme.Style.primaryTextColor
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        ColumnLayout {
            spacing: 2
            anchors.fill: parent
            anchors.topMargin: 60
            anchors.bottomMargin: 0
            StackLayout  {
                id: swipeView
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.topMargin: 10
                currentIndex: tabBar.currentIndex

                ColumnLayout {
                    spacing: 15
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.rightMargin: 20
                        Layout.leftMargin: 20
                        Column {
                            anchors.centerIn: parent
                            spacing: 18
                            Qaterial.Icon {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: 'transparent'
                                icon: Providers.Icons.noActivity
                                size: parent.parent.width / 2.3
                            }
                            Controls.TextLabel {
                                anchors.horizontalCenter: parent.horizontalCenter
                                horizontalAlignment: Label.AlignHCenter
                                width: parent.parent.width - 60
                                wrapMode: Label.Wrap
                                font.pixelSize: 18
                                text: 'Aucune activité'
                            }
                        }
                    }
                }

                ColumnLayout {
                    Controls.DR {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.topMargin: 0
                        Layout.rightMargin: 20
                        Layout.leftMargin: 20
                        Flickable {
                            anchors.fill: parent
                            anchors.topMargin: 5
                            contentHeight: flickable_column.height + 20
                            clip: true
                            Column {
                                id: flickable_column
                                width: parent.width
                                spacing: 5
                                Controls.DR {
                                    width: children[0].width
                                    height: 25
                                    Controls.TextLabel {
                                        topPadding: 5
                                        leftPadding: 5
                                        text: 'ACCES RAPIDE'
                                        font.weight: Font.Normal
                                        opacity: 1
                                        font.pixelSize: 10
                                    }
                                }
                                Flow {
                                    width: parent.width
                                    spacing: 10
                                    leftPadding: 0
                                    rightPadding: 0
                                    ApplicationButton {
                                        text: 'Notes list'
                                        icon.source: Qaterial.Icons.scriptTextOutline
                                        onClicked: m_view.push(auto_load['view-depense'])//m_view.push(page_depense)
                                    }
                                    ApplicationButton {
                                        text: 'Add note'
                                        icon.source: Qaterial.Icons.scriptOutline
                                        onClicked: newNote.open()
                                    }
                                }
                            }
                        }
                    }
                }

            }
        }

        Component.onCompleted: swipeView.update()




        footer: QQ.Control {
            id: tabBar
            height: 70
            width: parent.width
            bottomInset: 0

            Material.primary: Material.Red
            property int currentIndex: 0
            background: Rectangle {
                //color: Qaterial.Colors.teal50
            }
            contentItem: RowLayout {
                spacing: 0
                ApplicationTabButton {
                    index: 0
                    iconText: 'Acceuil'
                    iconSource: Qaterial.Icons.homeOutline
                }
                ApplicationTabButton {
                    index: 1
                    iconText: 'Outils'
                    iconSource: Qaterial.Icons.viewGridOutline
                }
            }


        }

    }
}
