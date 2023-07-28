import QtQuick

import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import SpeedNote.Providers as Providers
import SpeedNote.Services

import SpeedNote.Model as Model

import QtQuick.Controls as QQ

import TextEditor

Component {
    Qaterial.Page {
        id: note_edit_page
        padding: 10
        property bool exist: false
        property int  currentId: -1
        property bool saved: false
        property var viewPage
        property var callback: ()=>{}

        Component.onCompleted: {
            if(exist) {
                Model.Note.sqlGet(currentId).then(function(rs){
                    _title.text = unescape(rs.label)
                    _description.textArea.text = Qt.atob(rs.description)
                    saved = true
                })
            }
        }

        DocumentHandler {
            id: document
            document: _description.textArea.textDocument
            cursorPosition: _description.textArea.cursorPosition
            selectionStart: _description.textArea.selectionStart
            selectionEnd: _description.textArea.selectionEnd

            property alias family: document.font.family
            property alias bold: document.font.bold
            property alias italic: document.font.italic
            property alias underline: document.font.underline
            property alias strikeout: document.font.strikeout
            property alias size: document.font.pixelSize

            onLoaded: function (text, format) {
                _description.textArea.textFormat = format
                _description.textArea.text = text
            }
        }

        Controls.BDialog {
            id: exitDialog
            alignCenter: true
            icon: Qaterial.Icons.alert
            title: 'this note is unsaved'
            message: 'Do you want to leave without save?'
            dialogButtons: [
                Controls.BDialogButton {
                    text: 'Leave'
                    foregroundColor: Qaterial.Colors.red
                    onClicked: {
                        exitDialog.close()
                        view.pop()
                    }
                },
                Controls.BDialogButton {
                    text: 'Save'
                    onClicked: {
                        exitDialog.close()
                        note_edit_page.save()
                    }
                }
            ]
        }

        QQ.Popup {
            id: colorDialog
            width: note_edit_page.width
            height: 60
            background: Rectangle {
                color: Qaterial.Colors.teal50
                radius: 6
            }
            x: -10

            y: 50
            Flickable {
                id: flow
                width: parent.width
                height: 40
                contentWidth: insideFlow.width + 10
                Flow
                  {
                      id: insideFlow
                      anchors.verticalCenter: parent.verticalCenter
                    Repeater
                    {
                      model: ['#000000', '#FFFFFF', '#f44336', '#E91E63', '#9C27B0', '#673AB7', '#3F51B5', '#2196F3', '#03A9F4', '#00BCD4', '#009688',
                        '#4CAF50', '#8BC34A', '#CDDC39', '#FFEB3B', '#FFC107', '#FF9800', '#FF5722', '#9E9E9E', '#607D8B', '#263238',
                        '#212121', '#3E2723',
                      ]
                      delegate: Qaterial.Button
                      {
                        topInset: 0
                        radius: width / 2
                        width: height
                        backgroundColor: modelData
                        focusPolicy: Qt.TabFocus
                        elevation: 0
                        onClicked: function()
                        {
                          document.textColor = modelData
                          colorDialog.close()
                        }
                      }
                    }
                  }
            }
        }

        QQ.Popup {
            id: sizeDialog
            width: note_edit_page.width
            height: 60
            background: Rectangle {
                color: Qaterial.Colors.teal50
                radius: 6
            }
            x: -10

            y: 50
            Flickable {
                id: flow2
                width: parent.width
                height: 40
                contentWidth: insideFlow2.width + 10
                Flow
                  {
                      id: insideFlow2
                      anchors.verticalCenter: parent.verticalCenter
                    Repeater
                    {
                      model: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70]
                      delegate: Qaterial.Button
                      {
                        topInset: 0
                        radius: (width / 2) + 3
                        width: height
                        backgroundColor: Qaterial.Colors.white
                        foregroundColor: Qaterial.Colors.black
                        text: ''
                        focusPolicy: Qt.TabFocus
                        elevation: 1
                        Controls.TextLabel {
                            anchors.centerIn: parent
                            text: modelData
                            font.bold: true
                            font.weight: Font.Bold
                            font.family: 'Lato'
                            bottomPadding: 3
                        }

                        onClicked: function()
                        {
                          document.size = modelData
                          sizeDialog.close()
                        }
                      }
                    }
                  }
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            anchors.topMargin: 0
            visible: parent.height > 250
            enabled: parent.height > 250
            spacing: 10
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: -5
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: _title.implicitHeight + 5
                    Controls.TextField {
                        id: _title
                        anchors.fill: parent
                        leftPadding: 0
                        x: -10
                        wrapMode: Controls.TextLabel.Wrap
                        placeholderText: 'Title ...'
                        placeholderfont.pixelSize: 21
                        placeholderfont.weight: Font.Normal
                        background: Item {}
                        font.pixelSize: 21
                        opacity: displayText === "" ? .3 : 1
                        font.weight: displayText === "" ? Font.Normal : Font.Medium
                        onDisplayTextChanged: note_edit_page.saved = false
                    }
                }
                Qaterial.Button {
                    radius: 18
                    text: saved ? 'Saved' : 'Not save'
                    backgroundColor: saved ? Qaterial.Colors.green : Qaterial.Colors.red
                    onClicked: note_edit_page.save()
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -10
                    color: Qaterial.Colors.teal50
                    radius: 6
                }

                Rectangle {
                    width: parent.width + 20
                    height: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: Qaterial.Colors.gray200
                }

                Flickable {
                    anchors.fill: parent
                    anchors.margins: -10
                    contentWidth: _row.width + 20
                    clip: true
                    Row {
                        id: _row
                        x: 5
                        height: parent.height
                        Qaterial.SquareButton {
                            visible: _description.textArea.canUndo
                            icon.source: Qaterial.Icons.undo
                            foregroundColor: Qaterial.Style.foregroundColor
                            focusPolicy: Qt.TabFocus
                            onClicked: _description.textArea.undo()
                        }
                        Qaterial.SquareButton {
                            visible: _description.textArea.canRedo
                            icon.source: Qaterial.Icons.redo
                            foregroundColor: Qaterial.Style.foregroundColor
                            focusPolicy: Qt.TabFocus
                            onClicked: _description.textArea.redo()
                        }
                        Qaterial.SquareButton {
                            id: boldButton
                            icon.source: Qaterial.Icons.formatBold
                            foregroundColor: checked ? Qaterial.Colors.red : Qaterial.Style.foregroundColor
                            checkable: true
                            focusPolicy: Qt.TabFocus
                            onClicked: {
                                if(checked) {
                                    document.bold = true
                                }
                                else {
                                    document.bold = false
                                }
                            }
                            Connections {
                                target: document
                                function onBoldChanged() {
                                    boldButton.checked = document.bold
                                }
                            }
                        }
                        Qaterial.SquareButton {
                            id: italicButton
                            icon.source: Qaterial.Icons.formatItalic
                            foregroundColor: checked ? Qaterial.Colors.red : Qaterial.Style.foregroundColor
                            focusPolicy: Qt.TabFocus
                            checkable: true
                            onClicked: document.italic = !document.italic
                            Connections {
                                target: document
                                function onItalicChanged() {
                                    italicButton.checked = document.italic
                                }
                            }
                        }
                        Qaterial.SquareButton {
                            id: underlineButton
                            icon.source: Qaterial.Icons.formatUnderline
                            foregroundColor: checked ? Qaterial.Colors.red : Qaterial.Style.foregroundColor
                            checkable: true
                            focusPolicy: Qt.TabFocus
                            onClicked: {
                                document.underline = !document.underline
                            }
                            Connections {
                                target: document
                                function onUnderlineChanged() {
                                   underlineButton.checked = document.underline
                                }
                            }
                        }
                        Qaterial.SquareButton {
                            id: strikeButton
                            icon.source: Qaterial.Icons.formatStrikethroughVariant
                            foregroundColor: checked ? Qaterial.Colors.red : Qaterial.Style.foregroundColor
                            checkable: true
                            focusPolicy: Qt.TabFocus
                            onClicked: document.strikeout = !document.strikeout
                            Connections {
                                target: document
                                function onStrikeoutChanged() {
                                    strikeButton.checked = document.strikeout
                                }
                            }
                        }

                        Qaterial.SquareButton {
                            id: colorButton
                            icon.source: Qaterial.Icons.circleOutline
                            foregroundColor: document.textColor
                            focusPolicy: Qt.TabFocus
                            onClicked: colorDialog.open()
                        }

                        Qaterial.SquareButton {
                            id: sizeButton
                            icon.source: Qaterial.Icons.formatSize
                            foregroundColor: Qaterial.Style.foregroundColor
                            focusPolicy: Qt.TabFocus
                            onClicked: sizeDialog.open()
                        }

                        Qaterial.SquareButton {
                            id: alignLeftButton
                            icon.source: Qaterial.Icons.formatAlignLeft // icon-align-left
                            focusPolicy: Qt.NoFocus
                            checkable: true
                            checked: document.alignment == Qt.AlignLeft
                            onClicked: document.alignment = Qt.AlignLeft
                        }
                        Qaterial.SquareButton {
                            id: alignCenterButton
                            icon.source: Qaterial.Icons.formatAlignCenter// icon-align-center
                            focusPolicy: Qt.NoFocus
                            checkable: true
                            checked: document.alignment == Qt.AlignHCenter
                            onClicked: document.alignment = Qt.AlignHCenter
                        }
                        Qaterial.SquareButton {
                            id: alignRightButton
                            icon.source: Qaterial.Icons.formatAlignRight // icon-align-right
                            focusPolicy: Qt.NoFocus
                            checkable: true
                            checked: document.alignment == Qt.AlignRight
                            onClicked: document.alignment = Qt.AlignRight
                        }
                        Qaterial.SquareButton {
                            id: alignJustifyButton
                            icon.source: Qaterial.Icons.formatAlignJustify // icon-align-justify
                            font.family: "fontello"
                            focusPolicy: Qt.NoFocus
                            checkable: true
                            checked: document.alignment == Qt.AlignJustify
                            onClicked: document.alignment = Qt.AlignJustify
                        }

                    }
                }
            }


            Item {
                width: 10
                height: 10
            }

            Controls.TextArea {
                id: _description
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pixelSize: 20
                font.weight: Font.Normal
                Layout.leftMargin: -10
                onTextChanged: {
                    note_edit_page.saved = false
                }
            }

        }

        Controls.BFloatButton {
            icon.source: Qaterial.Icons.arrowLeft
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            onClicked: {
                if(note_edit_page.saved) {
                    view.pop()
                } else {
                    exitDialog.open()
                }
            }
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered:  {
                console.log(Qt.inputMethod.visible, Qt.inputMethod.keyboardRectangle.height)
            }
        }

        function save() {
            if(note_edit_page.exist) {
                Model.Note.sqlUpdate(note_edit_page.currentId, {label: escape(_title.text), description: Qt.btoa(_description.textArea.text)}).then(function(){
                    Model.Note.fetch()
                    viewPage.load(note_edit_page.currentId)
                    note_edit_page.saved = true
                }).catch(function(e){
                    Log.debug(e)
                })

            } else {
                Model.Note.sqlCreate({label: _title.text, description: Qt.btoa(_description.textArea.text)}).then(function(rs){
                    Model.Note.fetch()
                    note_edit_page.exist = true
                    note_edit_page.currentId = rs.id
                    note_edit_page.saved = true
                })
            }
        }
    }
}
