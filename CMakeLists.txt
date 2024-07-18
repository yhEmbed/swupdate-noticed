cmake_minimum_required(VERSION 3.5)

set(TARGET_NAME swupdate_noticed)

project(${TARGET_NAME} LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src/swupdate/inc/)
find_package(Qt5 COMPONENTS Core Quick REQUIRED)

set(SOURCES
    src/main.cpp
    src/upgradewindows.cpp
    qml.qrc
)
add_executable(${TARGET_NAME} ${SOURCES})

#add_definitions(-DUBUNTU_DEBUG)
find_library(SWUPDATE_LIBRARY NAMES swupdate)
target_link_libraries(${TARGET_NAME} PRIVATE ${SWUPDATE_LIBRARY})

target_compile_definitions(${TARGET_NAME}
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${TARGET_NAME}
  PRIVATE Qt5::Core Qt5::Quick)

INSTALL(TARGETS ${TARGET_NAME}
        RUNTIME DESTINATION /usr/bin)

