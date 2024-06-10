set(TS_FILES translations/SWUpdateNoticed_zh_CN.ts)

set(SOURCES
    main.cpp
    swupdateapp.cpp
    qml.qrc
    ${TS_FILES}
)

find_library(SWUPDATE_LIBRARY NAMES swupdate)

add_executable(SWUpdateNoticed ${SOURCES})

qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})

target_compile_definitions(SWUpdateNoticed
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(SWUpdateNoticed
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick ${SWUPDATE_LIBRARY})
