import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root
    visible: true
    width: swidth
    height: sheight
    maximumWidth: swidth
    maximumHeight: sheight
    minimumWidth: swidth
    minimumHeight: sheight
    //color: "transparent"

//    flags: Qt.FramelessWindowHint
//    //{{ Displayed in the taskbar when the window is at a minimumsize state
//           | Qt.WindowSystemMenuHint
//           | Qt.WindowMinimizeButtonHint
//           | Qt.Window


    ProgressBar {
        id: progressBar
        width: parent.width - 40
        anchors.verticalCenter: parent.verticalCenter
        value: 0.5 // 设置初始进度值
    }
}
