import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: r
    property int percent: 0
    implicitWidth: 200
    implicitHeight: 16
    //枚举， 表示右侧Bar的类型
    enum BarType {
        Text,               //右侧放文本
        SucceedOrFailed,    //右侧放图片表示成功和失败，没有100%就是失败
        NoBar               //右侧不放东西
    }
    //只读属性，内置一些颜色
    readonly property color __backColor: "#f5f5f5"
    readonly property color __blueColor: "#1890ff"
    readonly property color __succeedColor: "#52c41a"
    readonly property color __failedColor: "#f5222d"

    //背景色，默认值
    property color backgroundColor: __backColor
    //前景色
    property color frontColor: {
        switch (barType) {
        case TNormalProgress.BarType.SucceedOrFailed:
            return percent === 100 ? __succeedColor : __failedColor
        default:
            return __blueColor
        }
    }
    //文字
    property string text: String("%1%").arg(percent)
    //渐变 0-180 除掉不能用的，165种渐变任你选
    property int gradientIndex: -1
    //闪烁特效
    property bool flicker: false
    //右侧Bar类型
    property var barType: TNormalProgress.BarType.Text
    Text {
        id: t
        enabled: barType === TNormalProgress.BarType.Text
        visible: enabled
        text: r.text
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }
    Image {
        id: image
        source: percent === 100 ? "qrc:/Core/Image/ProgressBar/ok_circle.png" : "qrc:/Core/Image/ProgressBar/fail_circle.png"
        height: parent.height
        width: height
        enabled: barType === TNormalProgress.BarType.SucceedOrFailed
        visible: enabled
        anchors.right: parent.right
    }

    property var __right: {
        switch (barType) {
        case TNormalProgress.BarType.Text:
            return t.left
        case TNormalProgress.BarType.SucceedOrFailed:
            return image.left
        default:
            return r.right
        }
    }
    Rectangle {                             //背景
        id: back
        anchors.left: parent.left
        anchors.right: __right
        anchors.rightMargin: 4
        height: parent.height
        radius: height / 2
        color: backgroundColor
        Rectangle {                         //前景
            id: front
            width: percent / 100 * parent.width
            height: parent.height
            radius: parent.radius
            color: frontColor
            gradient: gradientIndex === -1 ? null : gradientIndex
            Rectangle {                     //前景上的闪光特效
                id: flick
                height: parent.height
                width: 0
                radius: parent.radius
                color: Qt.lighter(parent.color, 1.2)
                enabled: flicker
                visible: enabled
                NumberAnimation on width {
                    running: visible
                    from: 0
                    to: front.width
                    duration: 1000
                    loops: Animation.Infinite;
                }
            }
        }
    }
}

