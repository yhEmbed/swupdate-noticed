cmake_minimum_required(VERSION 3.5)

project(ota-upgrade-ui LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
add_definitions(-DUBUNTU_DEBUG)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src/swupdate/inc/)
# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

if(ANDROID)
    add_library(ota-upgrade-ui SHARED
      src/main.cpp
      src/upgradewindows.cpp
      qml.qrc
    )
else()
    add_executable(ota-upgrade-ui
      src/main.cpp
      src/upgradewindows.cpp
      qml.qrc
    )
endif()

target_compile_definitions(ota-upgrade-ui
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(ota-upgrade-ui
  PRIVATE Qt5::Core Qt5::Quick)
