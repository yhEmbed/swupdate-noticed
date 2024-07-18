import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Rectangle {
    id: upgradeWindowsId
    // Variables need to be defined in the outermost Rectangle layer
    property int percent: 10

    width: mainWinId.width
    height: mainWinId.height
    anchors.centerIn: parent
    color: "white"
    opacity: gUbuntuDebug === 1 ? 1 : 0
    Component.onCompleted: {
        console.log(gRatioW,gRatioH)
        console.log(width,height)
    }

    Connections{
        target: gUpgradeWin
        function onQmlVisibleChanged(visible){
            console.log("onQmlVisibleChanged visible:", visible)
            colId.visible = visible;
            imgId.visible = visible;
            upgradeWindowsId.opacity = 1;
        }

        function onQmlSwupdateProgChanged(str, pProgress){
            console.log("slotSwupdateProgChange str:", str,", progress:", pProgress)
            upgradeWindowsId.percent = pProgress;
            upgradePercentTextId.text = upgradeWindowsId.percent + "%"
            upgradeStateTextId.text = str;
        }

        function onQmlImageNameChanged(str){
            imageNameTextId.text = str;
        }
    }

    Image {
        id: imgId
        visible: gUbuntuDebug === 1 ? true : false
        source: "../image/background.png"
        anchors.fill: parent
    }
    Item {
        id: colId
        anchors.fill: parent
        visible: gUbuntuDebug === 1 ? true : false
        Rectangle{
            id: recTopId
            width: parent.width * 0.58
            height: parent.height * 0.26
            anchors.horizontalCenter: colId.horizontalCenter
            y: parent.height * 0.046
            color: "white"
            opacity: 0.8
            radius: upgradeWindowsId.height / 100
            Column{
                id: recTopColId
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
                        anchors.fill: parent
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
            opacity: 0.8
            radius: upgradeWindowsId.height / 100
            Column{
                id: recMidColId
                anchors.fill: parent
                /* tool icon */
                Item{
                    id: recMidColRec1Id
                    width: parent.width
                    height: parent.height * 0.33
                    anchors.horizontalCenter: parent.horizontalCenter
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
                /* upgrade status info*/
                Item{
                    id: recMidColRec2Id
                    width: parent.width
                    height: parent.height * 0.33
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle{
                        width: parent.width * 0.95
                        height: parent.height * 0.7
                        anchors.centerIn: parent
                        radius: upgradeWindowsId.height / 100
                        color: "white"

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
                            id: upgradeStateTextId
                            text: qsTr("Update not started.")
                            font.pixelSize: parent.height * 0.3
                            color: "black"
                            anchors.left: recMidColRec2Item2Id.right
                            anchors.leftMargin: parent.width * 0.02
                            anchors.verticalCenter: parent.verticalCenter
                        }

                    }
                }
                /* upgraded progress bar*/
                Item{
                    id: recMidColRec3Id
                    width: parent.width
                    height: parent.height * 0.33
                    anchors.horizontalCenter: parent.horizontalCenter
                    /* upgrade image name */
                    Text{
                        id: imageNameTextId
                        width: parent.width * 0.95
                        height: parent.height * 0.3
                        anchors.top: parent.top
                        anchors.topMargin: parent.height * 0.09
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("openlinux-image-weston-openlinux-atk-rk3568-evb.ext4.gz")
                        font.pixelSize: parent.height * 0.2
                    }

                    /* progress bar*/
                    Rectangle{
                        id: progressRect
                        width: parent.width * 0.95
                        height: parent.height * 0.3
                        anchors.top: imageNameTextId.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "white"

                        Rectangle{
                            id: progressRect2
                            width: (upgradeWindowsId.percent / 100) * parent.width
                            height: parent.height
                            radius: parent.radius
                            color: "#0e56f2"
                        }
                        Text {
                            id: upgradePercentTextId
                            width: parent.width * 0.1
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("0%")
                            font.pixelSize: upgradeWindowsId.height * 0.03
                        }
                    }

                }
            }
        }
        Rectangle{
            id: recBottomId
            width: upgradeWindowsId.width * 0.58
            height: upgradeWindowsId.height  * 0.1
            anchors.horizontalCenter: colId.horizontalCenter
            anchors.top: recMidId.bottom
            anchors.topMargin: upgradeWindowsId.height * 0.025
            color: "white"
            opacity: 0.8
            radius: upgradeWindowsId.height / 100
            Item{
                id: column
                anchors.fill: parent
                /* open message button */
                Item{
                    id: messageItem1Id
                    width: parent.width / 2
                    height: upgradeWindowsId.height * 0.05
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: upgradeWindowsId.height * 0.02
                    anchors.leftMargin: upgradeWindowsId.width * 0.01
                    Item{
                        id: messageIconId
                        width: upgradeWindowsId.height * 0.02
                        height: width
                        anchors.left: parent.left
                        anchors.leftMargin: upgradeWindowsId.width * 0.01
                        anchors.verticalCenter: parent.verticalCenter
                        Image {
                            source: "../image/iconMesg.png"
                            anchors.fill: parent
                        }
                    }
                    Text {
                        id: msgTextId
                        text: qsTr("Messages")
                        font.pixelSize: upgradeWindowsId.height * 0.025
                        color: "#2766f0"
                        anchors.left: messageIconId.right
                        anchors.leftMargin: upgradeWindowsId.height * 0.02
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea{
                        anchors.fill: messageItem1Id
                        onClicked: {
                            msgItmId.visible = !msgItmId.visible
                            console.log("msgItmId.visible:",  msgItmId.visible)
                            if(msgItmId.visible == true){
                                recBottomId.height = upgradeWindowsId.height  * 0.3
                                msgItmId.height = recBottomId.height * 0.6
                            } else{
                                recBottomId.height = upgradeWindowsId.height  * 0.1
                                msgItmId.height = 0
                            }
                        }
                    }

                }
                /* message display */
                Item{
                    id: msgItmId
                    width: parent.width * 0.95
                    height: 0
                    clip: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: messageItem1Id.bottom
                    anchors.topMargin: upgradeWindowsId.height * 0.010
                    visible: false
                    ScrollView {
                        anchors.fill: parent
                        background: Rectangle {
                            anchors.fill: parent
                            color: "white"
                            border.color: "gray"
                            radius: upgradeWindowsId.height / 100
                        }
                        TextArea {
                            id: contentText
                            anchors.fill: parent
                            readOnly: true
                            font.pixelSize: upgradeWindowsId.height * 0.025
                            property int preContentHeight: 0
                            wrapMode: TextArea.Wrap;
                            selectByMouse: true;
                            color: "black"
                        }
                    }
                }
            }
        }
        /* ubuntu debug button */
        Button{
            width: 100
            height: 50
            visible: gUbuntuDebug === 1 ? true : false
            text: "visiable"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    imgId.visible = !imgId.visible
                    colId.visible = !colId.visible
                }
            }
        }
        Button{
            width: 100
            height: 50
            visible: gUbuntuDebug === 1 ? true : false
            y: 100
            text: "percent++"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    percent += 10
                }
            }
        }
        Button{
            width: 100
            height: 50
            visible: gUbuntuDebug === 1 ? true : false
            y: 200
            text: "percent--"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    percent -= 10

                }
            }
        }
        Button{
            width: 100
            height: 50
            visible: gUbuntuDebug === 1 ? true : false
            y: 300
            text: "send msg"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    contentText.text = contentText.text + "test message!"
                }
            }
        }
        /* ubuntu debug button, end */
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:1.75;height:480;width:640}
}
##^##*/
