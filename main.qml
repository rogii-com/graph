import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

import Graph 1.0
import '.'

Item {
    id: root
    objectName: 'root'

//    width: 800
    height: 600

    focus: true

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape)
        {
            console.log("resetProjectionMatrix()");
            graphCos.resetVP()
            graph2.resetVP()
            event.accepted = true;
        }
    }

//    property real dpMM: Screen.pixelDensity

//    onDpMMChanged: {
//        console.log("dpMM = " + dpMM)
//    }

    TextMetrics {
        id: labelFontMetrics

        property real dpMM: Screen.pixelDensity

        font.family: "Arial"
        font.pixelSize: 4 * dpMM

        text: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    }

    WellBar {
        id: wellBar
        objectName: 'wellBar'

        width: logTracksRow.childrenRect.width - logTracksRow.children[0].width

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: logTracksRow.children[0].width + logTracksRow.spacing

        color: Qt.lighter("green")

        title: "JOHNB2"

        onDoubleClicked: {
            console.log(title + " double clicked!")
        }
    }

//    Rectangle {
//        id: wellBar

//        width: logTracksRow.childrenRect.width - logTracksRow.children[0].width
////        height: childrenRect.height + 6
//        height: labelFontMetrics.height * 1.10

//        anchors.top: parent.top
//        anchors.left: parent.left
//        anchors.leftMargin: logTracksRow.children[0].width + logTracksRow.spacing

//        color: Qt.lighter("green")

//        onHeightChanged: {
//            console.log("wellBar.height changed to "+ height)
//        }

//        function setupHeight()
//        {
////            console.log(labelFontMetrics.height + ", " + wellIcon.height)

////            var spacing = 3;
////            var maxHeight = Math.max(labelFontMetrics.height, wellIcon.height)
////            height = maxHeight + 2 * spacing
//        }

//        Text {
//            id: wellTitle

//            font: labelFontMetrics.font

//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.verticalCenter: parent.verticalCenter
//            text: "JOHNB2"
//        }

//        Image {
//            id: wellIcon

//            height: 0.8 * labelFontMetrics.height
//            width: height

//            anchors.verticalCenter: wellTitle.verticalCenter
//            anchors.right: wellTitle.left
//            anchors.rightMargin: 0.25 * width

//            source: "qrc:///scenegraph/graph/shaders/lateral_mask.png"
//        }
//    }

    Row {
        id: logTracksRow

        width: wellBar.width
        height: parent.height - wellBar.height

        anchors.bottom: parent.bottom

//        spacing: 1

        Item {
            id: scaleTrack

            width: childrenRect.width
            height: parent.height

            //anchors.left: firstTrack.right
            //anchors.top: parent.top

            Rectangle {
                id: scaleTrackRect

                objectName: 'scaleTrackRect'

                width: scaleNameComboBox.width
                height: 30

                anchors.topMargin: 60
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                color: "yellow"

                ComboBox {
                    id: scaleNameComboBox
                    model: [ "TVDSS", "TVD", "TVT", "MD" ]
                }
            }
        }

        Item {
            id: firstTrack

            width: 249
            height: parent.height

            //anchors.left: firstTrack.right
            //anchors.top: parent.top

            Rectangle {
                id: trackBarAF90

                width: parent.width
                // plus 10%
                height: labelFontMetrics.height * 1.10
//                height: 30

//                function setupHeight()
//                {
//                    var spacing = 3;
//                    var maxHeight = Math.max(logTitleAF90.height,
//                                             logMinValueAF90.height,
//                                             logMaxValueAF90.height)
//                    var wellBarHeight = wellBar.height
//                    height = Math.max(maxHeight + 2 * spacing, wellBarHeight)
//                }

                anchors.topMargin: 0
                anchors.top: parent.top

                color: Qt.darker("orange")

                GraphLabel {
                    id: logMin

                    textMetrics: labelFontMetrics

                    elide: Text.ElideRight
                    width: 0.25 * parent.width

                    text: '0.3'

                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                }

//                Text {
//                    id: logMin

//                    font: labelFontMetrics.font

//                    anchors.left: parent.left
//                    anchors.leftMargin: 5
//                    anchors.verticalCenter: parent.verticalCenter

//                    text: "0.3"

//                    Rectangle {
//                        id: dragIndicator

////                        anchors.fill: parent
//                        anchors.top: parent.top
//                        anchors.bottom: parent.bottom

//                        width: parent.width

//                        color: "red"
//                        opacity: 0.3

//                        Drag.active: logMinMouseArea.drag.active
//                        Drag.hotSpot.x: width / 2
//                        Drag.hotSpot.y: height / 2

//                        visible: Drag.active
//                    }

//                    MouseArea {
//                        id: logMinMouseArea

//                        anchors.fill: parent

//                        cursorShape: Qt.SplitHCursor

//                        drag.target: dragIndicator
//                        drag.smoothed: false
//                        drag.threshold: 0
//                    }
//                }

                GraphLabel {
                    id: logTitle

                    textMetrics: labelFontMetrics

                    elide: Text.ElideMiddle
                    width: 0.4 * parent.width

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "AF90"
                }

                GraphLabel {
                    id: logMax

                    textMetrics: labelFontMetrics

                    elide: Text.ElideLeft
                    width: 0.25 * parent.width

                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter

                    text: "209.3"
                }
            }

            Rectangle {
                id: trackBarAT90

                width: parent.width
//                height: 30

                function setupHeight()
                {
                    var spacing = 3;
                    var maxHeight = Math.max(/*logTitleAF90.height,*/
                                             logMinValueAT90.height,
                                             logMaxValueAT90.height)
                    var wellBarHeight = wellBar.height
                    height = Math.max(maxHeight + 2 * spacing, wellBarHeight)
                }

                anchors.top: trackBarAF90.bottom

                color: graphCos.lineColor

                Text {
                    id: logTitleCos

                    font: labelFontMetrics.font

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "AT90"
                }

                Text {
                    id: logMinValueAT90

                    font: labelFontMetrics.font

                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter

                    text: "0.9"
                }

                Text {
                    id: logMaxValueAT90

                    font: labelFontMetrics.font

                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter

                    text: "868.5"
                }

                Connections {
                    target: logTitleCos

                    onHeightChanged: {
                        trackBarAT90.setupHeight()
                    }
                }

                Connections {
                    target: logMinValueAT90

                    onHeightChanged: {
                        trackBarAT90.setupHeight()
                    }
                }

                Connections {
                    target: logMaxValueAT90

                    onHeightChanged: {
                        trackBarAT90.setupHeight()
                    }
                }

                Connections {
                    target: wellBar

                    onHeightChanged: {
                        trackBarAT90.setupHeight()
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    onDoubleClicked: {
                        parent.visible = !parent.visible
                    }
                }
            }

            Graph {
                id: graphCos

                anchors.top: trackBarAT90.bottom

                width: parent.width
                height: parent.height - trackBarAF90.height - trackBarAT90.height

                clip: true

                lineColor: Qt.lighter("green")

                //            rotation: 35

                property point mLastPosition: Qt.point(-1, -1)

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        if (mouse.button === Qt.LeftButton)
                            parent.mLastPosition = Qt.point(mouse.x, mouse.y)

                        console.log("onPressed: " + mouse);
                    }

                    onReleased: {
                        if (mouse.button === Qt.LeftButton)
                            parent.mLastPosition = Qt.point(-1, -1)

                        console.log("onReleased: " + mouse);
                    }

                    onPositionChanged: {
                        console.log("onPositionChanged: " + mouse);

                        if (mouse.buttons !== Qt.LeftButton)
                        {

                            console.log("if (mouse.button !== Qt.LeftButton)");
                            return;
                        }

                        if (parent.mLastPosition === Qt.point(-1, -1))
                        {

                            console.log("if (mLastPosition === Qt.point(-1, -1))");
                            return;
                        }

                        graphCos.shiftScene(parent.mLastPosition.x - mouse.x,
                                            parent.mLastPosition.y - mouse.y)

                        parent.mLastPosition = Qt.point(mouse.x, mouse.y);
                    }
                }

                function newSample(i) {
                    return (Math.sin(i / 100.0 * Math.PI * 2) + 1) * 0.4 + Math.random() * 0.05;
                }

                Component.onCompleted: {
                    addStaticRawLog()
//                    var stepCount = 100;
//                    var minValue = -5;
//                    var maxValue = 5;

//                    for (var i = 0; i <= stepCount; ++i)
//                    {
//                        const factor = i / stepCount;
//                        var oneMinusFactor = (stepCount - i) / stepCount;

//                        var y = minValue * oneMinusFactor + maxValue * factor;
//                        var x = Math.cos(y);
//                        append(Qt.point(x, y));
//                    }
                }

                property int offset: 100;

                Rectangle {
                    color: Qt.rgba(1, 1, 1, 0.7)
                    radius: 10
                    border.width: 1
                    border.color: parent.lineColor
                    anchors.fill: labelCos
                    anchors.margins: -10
                }

                //            TextField {
                //                id: labelCos
                //                color: "black"
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                //                anchors.margins: 20
                //                placeholderText: qsTr("Enter name")
                //            }

                //            Slider {
                //                id: labelCos
                //                value: 0.5
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                //                anchors.margins: 20
                //            }

                GroupBox {
                    id: labelCos
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 20

                    title: "Tab Position"

                    RowLayout {
                        RadioButton {
                            text: "ligther green"
                            checked: true
                            onCheckedChanged: {
                                if (checked)
                                    graphCos.lineColor = Qt.lighter("green")
                            }
                        }
                        RadioButton {
                            text: "Steelblue"
                            onCheckedChanged: {
                                if (checked)
                                    graphCos.lineColor = "steelblue"
                            }
                        }
                    }
                }

                //            Text {
                //                id: labelCos
                //                color: "black"
                //                wrapMode: Text.WordWrap
                //                text: "The background here is a squircle rendered with raw OpenGL using the 'beforeRender()' signal in QQuickWindow. This text label and its border is rendered using QML"
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                //                anchors.margins: 20
                //            }

//                Rectangle {
//                    anchors.fill: parent

//                    border.color: "black"
//                    border.width: 1

//                    opacity: 1
//                }
            }


            Rectangle {
                id: overlayResize

                anchors.fill: parent

                color: "red"

                visible: false
            }
        }

        Item {
            id: spacerBetweenFirstAndSecondTracks

            width: 10

            anchors.top: parent.top
            anchors.bottom: parent.bottom

            property point mLastPosition: Qt.point(-1, 1)

            MouseArea {
                id: betweenFirstAndSecondTrack

                anchors.fill: parent

//                hoverEnabled: true

                cursorShape: Qt.SizeHorCursor

                onPressed: {
                    if (mouse.button === Qt.LeftButton)
                        parent.mLastPosition = Qt.point(mouse.x, mouse.y)

                    console.log("onPressed: " + mouse);
                }

                onReleased: {
                    if (mouse.button === Qt.LeftButton)
                        parent.mLastPosition = Qt.point(-1, -1)

                    console.log("onReleased: " + mouse);
                }

                onPositionChanged: {
                    console.log("onPositionChanged: " + mouse);

                    if (mouse.buttons !== Qt.LeftButton)
                    {

                        console.log("if (mouse.button !== Qt.LeftButton)");
                        return;
                    }

                    if (parent.mLastPosition === Qt.point(-1, -1))
                    {

                        console.log("if (mLastPosition === Qt.point(-1, -1))");
                        return;
                    }

                    var deltaX = parent.mLastPosition.x - mouse.x
                    parent.mLastPosition = Qt.point(mouse.x, mouse.y);

                    firstTrack.width -= deltaX
                    secondTrack.width += deltaX
                }
            }
        }

        Item {
            id: secondTrack

            width: 150
            height: parent.height

            //anchors.left: firstTrack.right
            //anchors.top: parent.top

            Rectangle {
                id: secondTrackBar

                width: parent.width
                height: labelFontMetrics.height * 1.10

                anchors.topMargin: 30
                anchors.top: parent.top

                color: "orange"

                Text {
                    id: logTitleGr

                    font: labelFontMetrics.font

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "GR"
                }

                Text {
                    id: logMinValueGr

                    font: labelFontMetrics.font

                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter

                    text: "0.0"
                }

                Text {
                    id: logMaxValueGr

                    font: labelFontMetrics.font

                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter

                    text: "100.0"
                }
            }

            Graph {
                id: graph2

                anchors.top: parent.top
                anchors.topMargin: 60

                width: parent.width
                height: parent.height - 60

                clip: true

                lineColor: "orange"

                //            rotation: 35

                property point mLastPosition: Qt.point(-1, -1)

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        if (mouse.button === Qt.LeftButton)
                            parent.mLastPosition = Qt.point(mouse.x, mouse.y)

                        console.log("onPressed: " + mouse);
                    }

                    onReleased: {
                        if (mouse.button === Qt.LeftButton)
                            parent.mLastPosition = Qt.point(-1, -1)

                        console.log("onReleased: " + mouse);
                    }

                    onPositionChanged: {
                        console.log("onPositionChanged: " + mouse);

                        if (mouse.buttons !== Qt.LeftButton)
                        {

                            console.log("if (mouse.button !== Qt.LeftButton)");
                            return;
                        }

                        if (parent.mLastPosition === Qt.point(-1, -1))
                        {

                            console.log("if (mLastPosition === Qt.point(-1, -1))");
                            return;
                        }

                        graph2.shiftScene(parent.mLastPosition.x - mouse.x,
                                            parent.mLastPosition.y - mouse.y)

                        parent.mLastPosition = Qt.point(mouse.x, mouse.y);
                    }
                }

                function newSample(i) {
                    return (Math.sin(i / 100.0 * Math.PI * 2) + 1) * 0.4 + Math.random() * 0.05;
                }

                Component.onCompleted: {
                    var stepCount = 100;
                    var minValue = -5;
                    var maxValue = 5;

                    for (var i = 0; i <= stepCount; ++i)
                    {
                        const factor = i / stepCount;
                        var oneMinusFactor = (stepCount - i) / stepCount;

                        var y = minValue * oneMinusFactor + maxValue * factor;
                        var x = Math.cos(y);
                        append(Qt.point(x, y));
                    }
                }

                property int offset: 100;

                Rectangle {
                    color: Qt.rgba(1, 1, 1, 0.7)
                    radius: 10
                    border.width: 1
                    border.color: parent.lineColor
                    anchors.fill: label2
                    anchors.margins: -10
                }

                TextField {
                    id: label2
                    color: "black"
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 20
                    placeholderText: qsTr("Enter name")
                }

                //            Slider {
                //                id: labelCos
                //                value: 0.5
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                //                anchors.margins: 20
                //            }

//                GroupBox {
//                    id: labelCos
//                    anchors.right: parent.right
//                    anchors.left: parent.left
//                    anchors.top: parent.top
//                    anchors.margins: 20

//                    title: "Tab Position"

//                    RowLayout {
//                        RadioButton {
//                            text: "ligther green"
//                            checked: true
//                            onCheckedChanged: {
//                                if (checked)
//                                    graphCos.lineColor = Qt.lighter("green")
//                            }
//                        }
//                        RadioButton {
//                            text: "Steelblue"
//                            onCheckedChanged: {
//                                if (checked)
//                                    graphCos.lineColor = "steelblue"
//                            }
//                        }
//                    }
//                }

                //            Text {
                //                id: labelCos
                //                color: "black"
                //                wrapMode: Text.WordWrap
                //                text: "The background here is a squircle rendered with raw OpenGL using the 'beforeRender()' signal in QQuickWindow. This text label and its border is rendered using QML"
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                //                anchors.margins: 20
                //            }
            }
        }
    }
}
