import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Rectangle {
    id: root

    property alias fontFamily: labelFontMetrics.font.family
    property real fontSizeMm: 4

    property alias title: wellTitle.text
    // TODO: icon

    signal doubleClicked

    TextMetrics {
        id: labelFontMetrics

        property real dpMM: Screen.pixelDensity

        font.family: "Arial"
        font.pixelSize: root.fontSizeMm * dpMM

        text: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    }

    // plus 10%
    height: labelFontMetrics.height * 1.10

    Text {
        id: wellTitle

        font: labelFontMetrics.font

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: wellIcon

        height: 0.8 * labelFontMetrics.height
        width: height

        anchors.verticalCenter: wellTitle.verticalCenter
        anchors.right: wellTitle.left
        anchors.rightMargin: 0.25 * width

        source: "qrc:///scenegraph/graph/shaders/lateral_mask.png"
    }

    MouseArea {
        anchors.fill: parent

        onDoubleClicked: {
            root.doubleClicked()
        }
    }
}
