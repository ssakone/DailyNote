import QtQuick
import QtQuick.Layouts

import Qaterial as Qaterial

import SpeedNote.Components as Controls
import SpeedNote.Providers as Providers
import SortFilterProxyModel as SFPM

import SpeedNote.Model as Model

Component {
    id: m_depense
    Controls.BPage {
        id: depenseView
        Component.onCompleted: {
            Model.Note.fetch()
        }

        header: Controls.BTabBar {
            title: 'Daily Note'
            leading.visible: false
            titleLabel.leftPadding: 15
            titleLabel.bottomPadding: 8
            height: 45
        }

        SFPM.SortFilterProxyModel {
            id: proxy_depense_list_model
            sourceModel:  Model.Note
            filters: SFPM.RegExpFilter {
                roleName: "label"
                pattern: depense_search_field.text
                caseSensitivity: Qt.CaseInsensitive
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            anchors.topMargin: 0
            anchors.bottomMargin: 10

            Item {height: 5; visible: false}

            Controls.TextField {
                id: depense_search_field
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                placeholderText: 'Recherche'
                title: 'Recherche'
                horizontalAlignment: Qaterial.Label.AlignHCenter
                visible: false
                background: Rectangle {
                    radius: 21
                    color: Qaterial.Colors.gray200
                }
            }

            Item {height: 5; visible: false}

            Controls.TextLabel {
                text: 'Notes'
            }

            ListView {
                id: _note_list_view
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 6
                clip: true
                model: proxy_depense_list_model
                delegate: Controls.BItemDelegate {
                    width: _note_list_view.width
                    height: 60
                    backgroundColor: Qaterial.Colors.teal50
                    radius: 18
                    text: '%1'.arg(unescape(label))
                    secondaryText: '<font size="2"><b>%1</b><font/>'.arg(new Date(created_at).toDateString())
                    onClicked: {
                        AppAction.navigateTo(noteView, {exist: true, currentId: id})
                    }
                }
            }
        }
        Controls.BFloatButton {
            icon.source: Qaterial.Icons.plus
            onClicked: AppAction.navigateTo(newNote)
        }
    }
}
