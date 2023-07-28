cmake_minimum_required(VERSION 3.16)

project("SPEEDNOTE MOBILE" VERSION 0.1 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(Qt6 COMPONENTS Core Quick QuickControls2 Svg Xml Network REQUIRED)

include(cmake/dependencie.cmake)
include(cmake/ressource.cmake)

set(ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android)
set(QTAT_SHARING ON)
add_subdirectory(QtAndroidTools)
add_subdirectory(quickflux)

include_directories(quickflux/src)

if(ANDROID)
    set(ANDROID_DEPENDS
        android/AndroidManifest.xml
        android/build.gradle
        android/gradle.properties
    )
else()
    set(ANDROID_DEPENDS "")
endif()

qt_add_executable(DailyNote
    main.cpp
    src/SpeedNote/watcher.h
    src/SpeedNote/watcher.cpp
    src/SpeedNote/Property.hpp
    src/SpeedNote/androidtheme.h
    src/SpeedNote/androidtheme.cpp
    src/SpeedNote/utils.h
    src/SpeedNote/utils.cpp
    src/SpeedNote/documenthandler.h
    src/SpeedNote/documenthandler.cpp
    ${SpeedNote_UI_QML_RES}
    ${ANDROID_DEPENDS}
)

set_property(TARGET DailyNote APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android)

target_link_libraries(DailyNote
    PRIVATE
    Qt::Quick
    Qt::Quick
    Qt::Svg
    Qt::Xml
    Qt::QuickControls2
    Qt::Network
    Qt::Core
    Qaterial
    SortFilterProxyModel
    QtAndroidTools
    QuickFlux::quickflux
)

install(TARGETS DailyNote
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
