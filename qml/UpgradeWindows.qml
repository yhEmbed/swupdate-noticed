import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Rectangle {
    id: upgradeWindowsId
    // 变量需要在最外层Rectangle定义
    property int percent: 0

    width: 300
    height: 200
    anchors.centerIn: parent
    color: "white"
    // ubuntu 调试时 opacity=0.8
    opacity: gUbuntuDebug === 1 ? 0.8 : 0
    Component.onCompleted: {
        console.log(gRatioW,gRatioH)
        console.log(width,height)
        // 初始化窗口大小，比例缩放
        upgradeWindowsId.width = 300*gRatioW;
        upgradeWindowsId.height = 200;
        console.log(width,height)
    }
    radius: height/10

    //ubuntu调试使用
//    Button{
//        width: 50
//        height: 50
//        x:20
//        text: "visible"
//        onClicked: {
//            upgrade_col.visible = !upgrade_col.visible;
//        }
//    }
//    Button{
//        width: 50
//        height: 50
//        x:100
//        onClicked: {
//            if(progressBar.value > 0.8 && progressBar.value <= 0.9)
//                statusText.text = "升级即将完成..."
//            else if(progressBar.value > 0.9)
//                statusText.text = "升级完成，即将重启..."
//            progressBar.value += 0.1;
//            upgradeWindowsId.percent +=10;
//            progressRectTxt.text = upgradeWindowsId.percent + "%";
//            console.log("progressBar.value", progressBar.value)
//            console.log("upgradeWindowsId.percent", upgradeWindowsId.percent, progressRect2.width)
//        }
//        text: "+"
//    }
//    Button{
//        width: 50
//        height: 50
//        x:200
//        onClicked: {
//            progressBar.value -= 0.1;
//            upgradeWindowsId.percent -=10;
//            progressRectTxt.text = upgradeWindowsId.percent + "%";
//            console.log("progressBar.value", progressBar.value)
//            console.log("upgradeWindowsId.percent", upgradeWindowsId.percent, progressRect2.width)
//        }
//        text: "-"
//    }

    Column {
        id: upgrade_col
        anchors.horizontalCenter:  parent.horizontalCenter
        anchors.verticalCenter:   parent.verticalCenter
        width: upgradeWindowsId.width
        height: upgradeWindowsId.height
        spacing: 50
        // 默认不显示窗口
        visible: false
        function slotSwupdateProgChange(str, progress){
            console.log("slotSwupdateProgChange str:", str,", progress:", progress)
            upgradeWindowsId.percent = progress;
            progressRectTxt.text = upgradeWindowsId.percent + "%"
            statusText.text = str;
        }

        Connections{
            target: gUpgradeWin
            function onQmlVisibleChanged(visible){
                console.log("onQmlVisibleChanged visible:", visible)
                upgrade_col.visible = visible
                upgradeWindowsId.opacity = 0.8
            }
            function onQmlSwupdateProgChanged(str, pProgress){
                upgrade_col.slotSwupdateProgChange(str, pProgress);
            }
        }

        Text {
            text: "OTA Upgrade"
            anchors.horizontalCenter: upgrade_col.horizontalCenter
            height: 30
            font.pixelSize: 24
            font.bold: true
        }

        Rectangle{
            id: progressRect
            width: upgrade_col.width-100*gRatioW
            height: 30
            anchors.horizontalCenter:  upgrade_col.horizontalCenter
            color: "white"
            radius: height/2

            Rectangle{
                id: progressRect2
                width: (upgradeWindowsId.percent / 100) * parent.width
                height: parent.height
                radius: parent.radius
                color: "green"
            }
            Text {
                id: progressRectTxt
                width: 50
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("0%")
                font.pixelSize: 24
            }
        }
        //ubuntu调试使用
//        ProgressBar {
//            enabled: false
//            id: progressBar
//            width: upgrade_col.width - 100
//            height: 30
//            anchors.horizontalCenter:  upgrade_col.horizontalCenter
//            value: 0
//        }

        Text {
            id: statusText
            anchors.horizontalCenter: upgrade_col.horizontalCenter
            anchors.margins: 10
            text: "waitting for upgrade..."
            font.pixelSize: 18
        }
    }
}
