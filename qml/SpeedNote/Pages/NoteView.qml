import QtQuick

import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import SpeedNote.Providers as Providers
import SpeedNote.Services

import SpeedNote.Model as Model

import QtQuick.Controls as QQ

import QtAndroidTools

import TextEditor

Component {
    Qaterial.Page {
        id: note_view_page
        padding: 10
        property bool exist: false
        property int  currentId: -1
        Component.onCompleted: {
            load()
        }

        function load(){
            if(exist) {
                Model.Note.sqlGet(currentId).then(function(rs){
                    _title.text = unescape(rs.label)
                    _description.textArea.text = Qt.atob(rs.description)
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
            id: delDialog
            title: 'Delete this note'
            message: 'Did you want really to delete this note?'
            alignCenter: false
            dialogButtons: [
                Controls.BDialogButton {
                    text: 'Cancel'
                    onClicked: delDialog.close()
                },
                Controls.BDialogButton {
                    text: 'Accepter'
                    onClicked: {
                        delDialog.close()
                        Model.Note.sqlDelete(note_view_page.currentId).then(function(){
                            view.pop()
                            Model.Note.fetch()
                        })
                    }
                }
            ]
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            anchors.topMargin: 5
            visible: parent.height > 250
            enabled: parent.height > 250
            spacing: 0

            Controls.TextField {
                id: _title
                Layout.fillWidth: true
                leftPadding: 0
                x: -10
                wrapMode: Controls.TextLabel.Wrap
                placeholderText: 'Title ...'
                placeholderfont.pixelSize: 28
                placeholderfont.weight: Font.Normal
                background: Item {}
                font.pixelSize: 28
                opacity: displayText === "" ? .3 : 1
                font.weight: displayText === "" ? Font.Normal : Font.Medium
                readOnly: true
            }

            Item {
                width: 15
                height: 10
            }

            Controls.TextArea {
                id: _description
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pixelSize: 20
                font.weight: Font.Normal
                textArea.readOnly: true
                Layout.leftMargin: -10
            }
        }

        Controls.BFloatButton {
            icon.source: Qaterial.Icons.share
            width: 50
            height: 50
            anchors.bottomMargin: 170
            anchors.rightMargin: 15
            backgroundColor: Qaterial.Colors.blue
            elevation: 0
            onClicked: {
                _description.textArea.selectAll()
                QtAndroidSharing.shareText(_description.textArea.selectedText)
                _description.textArea.deselect()
            }
        }

        Controls.BFloatButton {
            icon.source: Qaterial.Icons.delete_
            width: 50
            height: 50
            anchors.bottomMargin: 130
            anchors.rightMargin: 15
            backgroundColor: Qaterial.Colors.red
            elevation: 0
            onClicked: delDialog.open()
        }

        Controls.BFloatButton {
            icon.source: Qaterial.Icons.arrowLeft
            width: 50
            height: 50
            anchors.bottomMargin: 75
            anchors.rightMargin: 15
            elevation: 0
            onClicked: AppAction.navigateBack()
        }
        Controls.BFloatButton {
            icon.source: Qaterial.Icons.pencil
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            onClicked: {
                AppAction.navigateTo(newNote,{exist: true, currentId: note_view_page.currentId, callback: note_view_page.load, viewPage: note_view_page})
            }
        }
    }
}
