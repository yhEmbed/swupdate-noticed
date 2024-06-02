import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ProgressBar {
        id: progressBar
        width: parent.width - 40
        height: 30
        anchors.centerIn: parent
        value: 0.5 // 设置初始进度值
    }

    Timer {
        interval: 100 // 进度更新间隔（单位：毫秒）
        repeat: true
        running: true

        onTriggered: {
            progressBar.value += 0.01 // 每次触发时增加进度值
            if (progressBar.value >= 1) {
                progressBar.value = 0 // 进度达到最大值后重置为0
            }
        }
    }

    Item {
        id: content

        Button {
            text: "Close Window"
            onClicked: {
                content.destroy();  // 销毁包含按钮的 Item
            }
        }
    }
}
