message(STATUS "Generate SpeedNote.qrc")
file(REMOVE qml/SpeedNote/Providers/Icons.qml qml/SpeedNote/Providers/Fonts.qml)

qt_generate_qrc(
  SpeedNote_RES_QRC
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml
  DEST_DIR ${CMAKE_CURRENT_SOURCE_DIR}
  NAME "SpeedNoteRes.qrc"
  PREFIX ""
  GLOB_EXPRESSION "*.svg" "*.png" "*.gif" "*.ttf"
  ALWAYS_OVERWRITE
  RECURSE
)

qt_generate_qrc_alias_qt_object(
  SpeedNote_QML_FONT
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml/SpeedNote/Ressources/Fonts
  NAME "qml/SpeedNote/Providers/Fonts.qml"
  PREFIX "SpeedNote/Ressources/Fonts"
  SINGLETON
  GLOB_EXPRESSION "*"
)

qt_generate_qrc_alias_qt_object(
  SpeedNote_QML_ROBOTO_FONT
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml/SpeedNote/Ressources/Fonts/Roboto
  NAME "qml/SpeedNote/Providers/RobotoDefaultFonts.qml"
  PREFIX "SpeedNote/Ressources/Fonts/Roboto"
  SINGLETON
  GLOB_EXPRESSION "*"
)

qt_generate_qrc_alias_qt_object(
  SpeedNote_QML_ROBOTO_CONDENSED_FONT
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml/SpeedNote/Ressources/Fonts/Roboto_condensed
  NAME "qml/SpeedNote/Providers/RobotoFonts.qml"
  PREFIX "SpeedNote/Ressources/Fonts/Roboto_Condensed"
  SINGLETON
  GLOB_EXPRESSION "*"
)


qt_generate_qrc_alias_qt_object(
  SpeedNote_QML_ICONS
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml/SpeedNote/Ressources/Icons
  NAME "qml/SpeedNote/Providers/Icons.qml"
  PREFIX "SpeedNote/Ressources/Icons"
  SINGLETON
  GLOB_EXPRESSION "*"
)

qt_generate_qrc(SpeedNote_QML_QRC
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml
  DEST_DIR ${CMAKE_CURRENT_SOURCE_DIR}
  NAME "SpeedNote.qrc"
  PREFIX "qml/"
  RECURSE
  ALWAYS_OVERWRITE
  GLOB_EXPRESSION "*.qml" "qmldir" "*.frag" "*.vert" "*.js"
)

qt6_add_resources(SpeedNote_UI_QML_RES ${SpeedNote_QML_QRC} ${SpeedNote_RES_QRC})
qt_generate_qmldir(SpeedNote_QML_DIR
 SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml
 MODULE "SpeedNote"
 RECURSE
 VERBOSE)

list(APPEND QML_IMPORT "${CMAKE_CURRENT_SOURCE_DIR}/qml")
list(APPEND QML_IMPORT ${QML_IMPORT_PATH})
list(APPEND QML2_IMPORT "${CMAKE_CURRENT_SOURCE_DIR}/qml")
list(APPEND QML2_IMPORT ${QML2_IMPORT_PATH})

message(STATUS ${QML_IMPORT_PATH})
set(QML_IMPORT_PATH "${QML_IMPORT}" CACHE STRING "Qt Creator 4.1 extra qml import paths" FORCE)
set(QML2_IMPORT_PATH "${QML_IMPORT}" CACHE STRING "Qt Creator 4.1 extra qml import paths" FORCE)
