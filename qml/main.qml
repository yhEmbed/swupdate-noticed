import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: mainWinId
    visible: true
    width: gScreenWidth
    height: gScreenHeight
    color: gUbuntuDebug === 1 ? "black" : "transparent"
    // Borderless window
    flags: Qt.FramelessWindowHint

    function convertDoubleToInt (x) {
        return x < 0 ? Math.ceil(x) : Math.floor(x);
    }

    StackView {
        id:stackView
        visible: true
        anchors.fill: parent
        initialItem: "qrc:/qml/UpgradeWindows.qml"
    }
}
