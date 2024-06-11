import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.5
import QtQml 2.0
Rectangle {
    id: upgradeWindowsId
 //   color: "transparent"
    color: "white"
    opacity: 0.8
    property int upgradeprog:  progressBar.value
    border.color: "black"
    Button{
        width: 50
        height: 50
        text: "visible"
        onClicked: {
            upgrade_col.visible = !upgrade_col.visible;
        }
    }

    Button{
        width: 50
        height: 50
        x:100
        onClicked: {
            if(progressBar.value > 0.8 && progressBar.value <= 0.9)
                statusText.text = "升级即将完成..."
            else if(progressBar.value > 0.9)
                statusText.text = "升级完成，即将重启..."
            console.log(progressBar.value)
            console.log(gVisible)

            progressBar.value += 0.1;

        }
        text: "+"
    }
    Button{
        width: 50
        height: 50
        x:200
        onClicked: {
            progressBar.value -= 0.1;
        }
        text: "-"
    }

    Column {
        id: upgrade_col
//        anchors.centerIn: parent

        anchors.horizontalCenter:  parent.horizontalCenter
        anchors.verticalCenter:   parent.verticalCenter
        width: 400
        height: 400
        spacing: 30

        visible: false
        function slotSwupdateProgChange(str, progress){
            console.log("slotSwupdateProgChange str:", str,", progress:", progress)
            progressBar.value = progress / 100;
            statusText.text = str;
        }

        Connections{
            target: gUpgradeWin
            function onQmlVisibleChanged(visible){
                console.log("onQmlVisibleChanged visible:", visible)
                upgrade_col.visible = visible
            }

            function onQmlSwupdateProgChanged(str, pProgress){
                upgrade_col.slotSwupdateProgChange(str, pProgress);
            }
        }

        Text {
            text: "OTA升级"
            width: upgrade_col.width
            height: 30
            anchors.horizontalCenter:  upgrade_col.horizontalCenter
            font.pixelSize: 24
            font.bold: true
        }

        ProgressBar {
            id: progressBar
            width: upgrade_col.width
            height: 30
            anchors.horizontalCenter:  upgrade_col.horizontalCenter
            value: 0
        }

        Text {
            id: statusText
            width: upgrade_col.width
            height: 30
            text: "正在检查更新..."
            font.pixelSize: 18
        }

        Row{
            id: burron_row
            width: upgrade_col.width
            height: 50
            spacing: burron_row.width / 4
            Button {
                id: startButton
                width: burron_row.width / 4
                text: "开始升级"
//                background: Rectangle{
//                    color: "transparent";
//                }

                enabled: true
    //            Layout.preferredWidth: 200
    //            Layout.preferredHeight: 50
                onClicked: {
                    // 在这里添加开始升级的逻辑
                    statusText.text = "开始升级"

                }
            }

            Button {
                id: cancelButton
                width: burron_row.width / 4
                text: "取消升级"
                enabled: true
    //            Layout.preferredWidth: 200
    //            Layout.preferredHeight: 50
                onClicked: {
                    // 在这里添加取消升级的逻辑
                }
            }
        }
    }
}
