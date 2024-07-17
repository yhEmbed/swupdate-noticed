import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Window {
    visible: true
    width: gScreenWidth
    height: gScreenHeight
    // // ubuntu debug color="black"
    color: gUbuntuDebug === 1 ? "black" : "transparent"
    // Borderless window
    flags: Qt.FramelessWindowHint

    StackView {
        id:stackView
        visible: true
        anchors.fill: parent
        initialItem: "qrc:/qml/UpgradeWindows.qml"

        // Gradient animation
        // Set up the entry animation
        pushEnter: Transition {
            SequentialAnimation {
                NumberAnimation {
                    target: stackView
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 500
                }
            }
        }
    }
}
