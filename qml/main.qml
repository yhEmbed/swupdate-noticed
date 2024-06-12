import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Window {
    visible: true
    width: gScreenWidth
    height: gScreenHeight
    // // ubuntu 调试时 color="black"
    color: gUbuntuDebug === 1 ? "black" : "transparent"
    // 无边框窗口
    flags: Qt.FramelessWindowHint
    StackView {
        id:stackView
        visible: true
        anchors.fill: parent
        initialItem: "qrc:/qml/UpgradeWindows.qml"

        // 渐变动画
        // 设置进入动画
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
