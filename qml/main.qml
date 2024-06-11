import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
Window {
    visible: true
    width: gScreenWidth
    height: gScreenHeight
    color: "transparent"

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
