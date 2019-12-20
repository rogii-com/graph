import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Text {
    id: root

    property TextMetrics textMetrics: null

    font: textMetrics.font

    property alias dragIndicatorColor: dragIndicator.color
    property alias dragIndicatorOpacity: dragIndicator.opacity

    property alias cursorShape: mouseArea.cursorShape

    Rectangle {
        id: dragIndicator

        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: parent.width

        color: "red"
        opacity: 0.3

        Drag.active: mouseArea.drag.active
        Drag.hotSpot.x: width / 2
        Drag.hotSpot.y: height / 2

        visible: Drag.active
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        cursorShape: Qt.SplitHCursor

        drag.target: dragIndicator
        drag.smoothed: false
        drag.threshold: 0
    }
}
