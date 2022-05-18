cmake_minimum_required(VERSION 3.16)

project("SPEEDNOTE MOBILE" VERSION 0.1 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(WIN32)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zc:__cplusplus /permissive-")
endif()

find_package(Qt6 COMPONENTS Quick QuickControls2 Svg Xml Network WebSockets REQUIRED)

include(cmake/dependencie.cmake)
include(cmake/ressource.cmake)


qt_add_executable(Desktop
    main.cpp
    src/SpeedNote/watcher.h
    src/SpeedNote/watcher.cpp
    src/SpeedNote/Property.hpp
    src/SpeedNote/androidtheme.h
    src/SpeedNote/androidtheme.cpp
    src/SpeedNote/utils.h
    src/SpeedNote/utils.cpp
    ${SpeedNote_UI_QML_RES}
)

target_link_libraries(Desktop
    PRIVATE
    Qt::Quick
    Qt::Quick
    Qt::Svg
    Qt::Xml
    Qt::QuickControls2
    Qt::Network
    Qt::WebSockets
    Qaterial
    SortFilterProxyModel
)
