import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Rectangle {
    id: upgradeWindowsId
    // Variables need to be defined in the outermost Rectangle layer
    property int percent: 10

    width: parent.width
    height: parent.height
    anchors.centerIn: parent
    color: "white"
    // ubuntu debug opacity=0.8
    opacity: gUbuntuDebug === 1 ? 1 : 0
    Component.onCompleted: {
        console.log(gRatioW,gRatioH)
        console.log(width,height)

    }
    Image {
        id: imgId
        source: "../image/background.png"
        anchors.fill: parent
    }

    Column {
        id: colId
        anchors.fill: parent
        width: upgradeWindowsId.width
        height: upgradeWindowsId.height
//        anchors.fill: parent

        Rectangle{
            id: recTopId
            width: parent.width * 0.58
            height: parent.height * 0.26
            anchors.horizontalCenter: colId.horizontalCenter
            y: parent.height * 0.046
            Component.onCompleted: {
                console.log(gRatioW,gRatioH)
                console.log(width,height)
            }
            color: "white"
            opacity: gUbuntuDebug === 1 ? 0.8 : 0
            radius: height / 10
            Column{
                id: recTopColId
                width: parent.width
                height: parent.height
                anchors.fill: parent
                Item{
                    width: parent.width * 0.9
                    height: parent.height * 0.2
                    anchors.horizontalCenter: parent.horizontalCenter
                    opacity: 0
                }
                Item{
                    width: parent.width * 0.9
                    height: parent.height * 0.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    opacity:1
                    Row{
                        Text {
                            text: qsTr("SW")
                            font.pixelSize: recTopColId.height * 0.2
                            color: "#2766f0"
                        }
                        Text {
                            text: qsTr("Update")
                            font.pixelSize: recTopColId.height * 0.2
                            color: "black"
                        }
                    }
                }
                Item{
                    width: parent.width * 0.9
                    height: parent.height * 0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        text: qsTr("Software update for embedded systems")
                        font.pixelSize: recTopColId.height * 0.09
                        color: "black"
                    }

                }
            }
        }

        Rectangle{
            id: recMidId
            width: parent.width * 0.58
            height: parent.height * 0.30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: recTopId.bottom
            anchors.topMargin: parent.height * 0.04
            color: "white"
            opacity: gUbuntuDebug === 1 ? 0.8 : 0
            radius: height / 10
            Column{
                id: recMidColId
                width: parent.width
                height: parent.height
                anchors.fill: parent
                Item{
                    id: recMidColRec1Id
                    width: parent.width
                    height: parent.height * 0.33
                    anchors.horizontalCenter: parent.horizontalCenter
                    Row{
                        width: parent.width
                        height: parent.height
                        Item{
                            id: recMidColRec1Item2Id
                            width: parent.height * 0.2
                            height: parent.height * 0.2
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.013
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                source: "../image/iconPark-tool.png"
                                anchors.fill: parent
                            }
                        }
                        Text {
                            text: qsTr("Software Update")
                            font.pixelSize: parent.height * 0.3
                            color: "black"
                            anchors.left: recMidColRec1Item2Id.right
                            anchors.leftMargin: parent.width * 0.02
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
                Item{
                    id: recMidColRec2Id
                    width: parent.width
                    height: parent.height * 0.33
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle{
                        width: parent.width * 0.95
                        height: parent.height * 0.7
                        anchors.centerIn: parent
                        radius: height / 10
                        color: "white"
//                        opacity: 0.8
                        Row{
                            width: parent.width
                            height: parent.height
                            Item{
                                id: recMidColRec2Item2Id
                                width: parent.height * 0.4
                                height: parent.height * 0.4
                                anchors.left: parent.left
                                anchors.leftMargin: parent.width * 0.013
                                anchors.verticalCenter: parent.verticalCenter
                                Image {
                                    source: "../image/iconPark-tool2.png"
                                    anchors.fill: parent
                                }
                            }
                            Text {
                                id: upgrdProcessTextId
                                text: qsTr("Update not started.")
                                font.pixelSize: parent.height * 0.3
                                color: "black"
                                anchors.left: recMidColRec2Item2Id.right
                                anchors.leftMargin: parent.width * 0.02
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }

                Item{
                    id: recMidColRec3Id
                    width: parent.width
                    height: parent.height * 0.33
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle{
                        id: progressRect
                        width: parent.width * 0.95
                        height: parent.height * 0.3
                        anchors.centerIn: parent
                        color: "white"

                        Rectangle{
                            id: progressRect2
                            width: (upgradeWindowsId.percent / 100) * parent.width
                            height: parent.height
                            radius: parent.radius
                            color: "#0e56f2"
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

                }
            }
        }
        Rectangle{
            id: recBottomId
            width: upgradeWindowsId.width * 0.58
            height: upgradeWindowsId.height  * 0.2
            anchors.horizontalCenter: colId.horizontalCenter
            anchors.top: recMidId.bottom
            anchors.topMargin: upgradeWindowsId.height * 0.025
            color: "white"
            opacity: gUbuntuDebug === 1 ? 0.8 : 0
            radius: height / 10
            Column{
                width: parent.width
                height: parent.height
                anchors.fill: parent
                Item{
                    id: messageItem1Id
                    width: parent.width * 0.95
                    height: parent.height * 0.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.1
                    Item{
                        id: messageIconId
                        width: parent.height * 0.2
                        height: parent.height * 0.2
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.013
                        anchors.verticalCenter: parent.verticalCenter
                        Image {
                            source: "../image/iconMesg.png"
                            anchors.fill: parent
                        }
                    }
                    Text {
                        text: qsTr("Messages")
                        font.pixelSize: recMidColId.height * 0.1
                        color: "#2766f0"
                        anchors.left: messageIconId.right
                        anchors.leftMargin: parent.width * 0.02
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Item{
                    width: parent.width * 0.95
                    height: parent.height * 0.4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: messageItem1Id.bottom
                    anchors.topMargin: parent.height * 0.05
//                    color: "blue"
//                    opacity: 0.2
                    ScrollView{
                        width: parent.width
                        height: parent.height
                        Text {
                            id: logText
                            text: "Log Messages:"
                            anchors.top: parent.top
                            anchors.left: parent.left
                            font.pixelSize: 18
                        }
                    }
                }
            }
        }
    }

    //ubuntu debug
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

//    Column {
//        id: upgrade_col
//        anchors.horizontalCenter:  parent.horizontalCenter
//        anchors.verticalCenter:   parent.verticalCenter
//        width: upgradeWindowsId.width
//        height: upgradeWindowsId.height
//        spacing: 50
//        // The window is not displayed by default
//        visible: false
//        function slotSwupdateProgChange(str, progress){
//            console.log("slotSwupdateProgChange str:", str,", progress:", progress)
//            upgradeWindowsId.percent = progress;
//            progressRectTxt.text = upgradeWindowsId.percent + "%"
//            statusText.text = str;
//        }

//        Connections{
//            target: gUpgradeWin
//            function onQmlVisibleChanged(visible){
//                console.log("onQmlVisibleChanged visible:", visible)
//                upgrade_col.visible = visible
//                upgradeWindowsId.opacity = 0.8
//            }
//            function onQmlSwupdateProgChanged(str, pProgress){
//                upgrade_col.slotSwupdateProgChange(str, pProgress);
//            }
//        }

//        Text {
//            text: "OTA Upgrade"
//            anchors.horizontalCenter: upgrade_col.horizontalCenter
//            height: 30
//            font.pixelSize: 24
//            font.bold: true
//        }

//        Rectangle{
//            id: progressRect
//            width: upgrade_col.width-100*gRatioW
//            height: 30
//            anchors.horizontalCenter:  upgrade_col.horizontalCenter
//            color: "white"
//            radius: height/2

//            Rectangle{
//                id: progressRect2
//                width: (upgradeWindowsId.percent / 100) * parent.width
//                height: parent.height
//                radius: parent.radius
//                color: "green"
//            }
//            Text {
//                id: progressRectTxt
//                width: 50
//                height: 30
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                text: qsTr("0%")
//                font.pixelSize: 24
//            }
//        }
//        //ubuntu调试使用
////        ProgressBar {
////            enabled: false
////            id: progressBar
////            width: upgrade_col.width - 100
////            height: 30
////            anchors.horizontalCenter:  upgrade_col.horizontalCenter
////            value: 0
////        }

//        Text {
//            id: statusText
//            anchors.horizontalCenter: upgrade_col.horizontalCenter
//            anchors.margins: 10
//            text: "waitting for upgrade..."
//            font.pixelSize: 18
//        }
//    }
}
