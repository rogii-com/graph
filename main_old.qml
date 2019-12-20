/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import Graph 1.0

//Row {
//    spacing: 2

//    Item {
//        width: 300
//        height: 800
//        x: 0
//        y: 0

//        property point mLastPosition: Qt.point(-1, -1)

//        focus: true

//        Keys.onPressed: {
//            if (event.key === Qt.Key_Escape)
//            {
//                console.log("resetProjectionMatrix()");
//                graphCos.resetVP()
//                graphSin.resetVP()
//                event.accepted = true;
//            }
//        }

//        MouseArea {
//            anchors.fill: parent

//            onClicked: {

//                console.log("onClicked: " + mouse);

//                if (mouse.button === Qt.RightButton)
//                {
//                    graphCos.resetVP()
//                    graphSin.resetVP()
//                }
//            }

//            onPressed: {
//                if (mouse.button === Qt.LeftButton)
//                    parent.mLastPosition = Qt.point(mouse.x, mouse.y)

//                console.log("onPressed: " + mouse);
//            }

//            onReleased: {
//                if (mouse.button === Qt.LeftButton)
//                    parent.mLastPosition = Qt.point(-1, -1)

//                console.log("onReleased: " + mouse);
//            }

//            onPositionChanged: {
//                console.log("onPositionChanged: " + mouse);

//                if (mouse.buttons !== Qt.LeftButton)
//                {

//                    console.log("if (mouse.button !== Qt.LeftButton)");
//                    return;
//                }

//                if (parent.mLastPosition === Qt.point(-1, -1))
//                {

//                    console.log("if (mLastPosition === Qt.point(-1, -1))");
//                    return;
//                }

//                graphCos.shiftScene(parent.mLastPosition.x - mouse.x,
//                                    parent.mLastPosition.y - mouse.y)
//                graphSin.shiftScene(parent.mLastPosition.x - mouse.x,
//                                    parent.mLastPosition.y - mouse.y)

//                parent.mLastPosition = Qt.point(mouse.x, mouse.y);
//            }
//        }

//        Graph {
//            id: graphCos
//            anchors.fill: parent
//            anchors.margins: 0
//            clip: true

//            lineColor: Qt.lighter("green")

////            rotation: 35

//            function newSample(i) {
//                return (Math.sin(i / 100.0 * Math.PI * 2) + 1) * 0.4 + Math.random() * 0.05;
//            }

//            Component.onCompleted: {
//                var stepCount = 100;
//                var minValue = -5;
//                var maxValue = 5;

//                for (var i = 0; i <= stepCount; ++i)
//                {
//                    const factor = i / stepCount;
//                    var oneMinusFactor = (stepCount - i) / stepCount;

//                    var y = minValue * oneMinusFactor + maxValue * factor;
//                    var x = Math.cos(y);
//                    append(Qt.point(x, y));
//                }
//            }

//            property int offset: 100;

//            Rectangle {
//                color: Qt.rgba(1, 1, 1, 0.7)
//                radius: 10
//                border.width: 1
//                border.color: parent.lineColor
//                anchors.fill: labelCos
//                anchors.margins: -10
//            }

////            TextField {
////                id: labelCos
////                color: "black"
////                anchors.right: parent.right
////                anchors.left: parent.left
////                anchors.top: parent.top
////                anchors.margins: 20
////                placeholderText: qsTr("Enter name")
////            }

////            Slider {
////                id: labelCos
////                value: 0.5
////                anchors.right: parent.right
////                anchors.left: parent.left
////                anchors.top: parent.top
////                anchors.margins: 20
////            }

//            GroupBox {
//                id: labelCos
//                anchors.right: parent.right
//                anchors.left: parent.left
//                anchors.top: parent.top
//                anchors.margins: 20

//                  title: "Tab Position"

//                  RowLayout {
//                      RadioButton {
//                          text: "ligther green"
//                          checked: true
//                          onCheckedChanged: {
//                              if (checked)
//                                  graphCos.lineColor = Qt.lighter("green")
//                          }
//                      }
//                      RadioButton {
//                          text: "Steelblue"
//                          onCheckedChanged: {
//                              if (checked)
//                                  graphCos.lineColor = "steelblue"
//                          }
//                      }
//                  }
//              }

////            Text {
////                id: labelCos
////                color: "black"
////                wrapMode: Text.WordWrap
////                text: "The background here is a squircle rendered with raw OpenGL using the 'beforeRender()' signal in QQuickWindow. This text label and its border is rendered using QML"
////                anchors.right: parent.right
////                anchors.left: parent.left
////                anchors.top: parent.top
////                anchors.margins: 20
////            }
//        }

//        Graph {
//            id: graphSin
//            anchors.fill: parent
//            anchors.margins: 0
//            clip: true

//            lineColor: "darkRed"

//            function newSample(i) {
//                return (Math.sin(i / 100.0 * Math.PI * 2) + 1) * 0.4 + Math.random() * 0.05;
//            }

//            Keys.onPressed: {
//                if (event.key === Qt.Key_Escape)
//                {
//                    console.log("resetProjectionMatrix()");
//                    resetProjectionMatrix()
//                    event.accepted = true;
//                }
//            }

//            Component.onCompleted: {
//                var stepCount = 100;
//                var minValue = -5;
//                var maxValue = 5;

//                for (var i = 0; i <= stepCount; ++i)
//                {
//                    const factor = i / stepCount;
//                    var oneMinusFactor = (stepCount - i) / stepCount;

//                    var y = minValue * oneMinusFactor + maxValue * factor;
//                    var x = Math.sin(y);
//                    append(Qt.point(x, y));
//                }
//            }

//            property int offset: 100;

//            Rectangle {
//                color: Qt.rgba(1, 1, 1, 0.7)
//                radius: 10
//                border.width: 1
//                border.color: parent.lineColor
//                anchors.fill: labelSin
//                anchors.margins: -10
//            }

//            Text {
//                id: labelSin
//                y: parent.y + 150
//                color: "black"
//                wrapMode: Text.WordWrap
//                text: "The background here is a squircle rendered with raw OpenGL using the 'beforeRender()' signal in QQuickWindow. This text label and its border is rendered using QML"
//                anchors.right: parent.right
//                anchors.left: parent.left
////                anchors.bottom: parent.bottom
////                anchors.top: parent.top
//                anchors.margins: 20
//            }
//        }

////        Timer {
////            id: timerSin
////            interval: 500
////            repeat: true
////            running: true
////            onTriggered: {
//////                    graph.removeFirstSample();
//////                    graph.appendSample(graph.newSample(++graph.offset));
////                graphSin.update();
////            }

////        }

////            Rectangle {
////                anchors.fill: graph
////                color: "transparent"
////                border.color: "black"
////                border.width: 2
////            }

//    }


////    Repeater {
////        model: 20000
////        clip: true

//////        Rectangle {
//////            width: 300
//////            height: 800

//////            color: "darkRed"
//////        }

////        Item {
////            width: 300
////            height: 800

////            property point mLastPosition: Qt.point(-1, -1)

////            MouseArea {
////                anchors.fill: parent

////                onClicked: {
////                    if (mouse.buttons === Qt.RightButton)
////                        graph.resetVP()
////                }

////                onPressed: {
////                    if (mouse.button === Qt.LeftButton)
////                        parent.mLastPosition = Qt.point(mouse.x, mouse.y)

////                    console.log("onPressed: " + mouse);
////                }

////                onReleased: {
////                    if (mouse.button === Qt.LeftButton)
////                        parent.mLastPosition = Qt.point(-1, -1)

////                    console.log("onReleased: " + mouse);
////                }

////                onPositionChanged: {
////                    console.log("onPositionChanged: " + mouse);

////                    if (mouse.buttons !== Qt.LeftButton)
////                    {

////                        console.log("if (mouse.button !== Qt.LeftButton)");
////                        return;
////                    }

////                    if (parent.mLastPosition === Qt.point(-1, -1))
////                    {

////                        console.log("if (mLastPosition === Qt.point(-1, -1))");
////                        return;
////                    }

////                    graph.shiftScene(parent.mLastPosition.x - mouse.x,
////                                        parent.mLastPosition.y - mouse.y)

////                    parent.mLastPosition = Qt.point(mouse.x, mouse.y);
////                }
////            }

////            Graph {
////                id: graph
////                anchors.fill: parent
////                anchors.margins: 0
////                clip: true

////                function newSample(i) {
////                    return (Math.sin(i / 100.0 * Math.PI * 2) + 1) * 0.4 + Math.random() * 0.05;
////                }

////                Component.onCompleted: {
//////                    for (var i=0; i<100; ++i)
//////                        appendSample(newSample(i));

////                    var stepCount = 100;
////                    var leftLimit = -20;
////                    var rightLimit = 10;

////                    for (var i = 0; i <= stepCount; ++i)
////                    {
////                        const factor = i / stepCount;
////                        var oneMinusFactor = (stepCount - i) / stepCount;

////                        var x = leftLimit * oneMinusFactor + rightLimit * factor;
////                        var sinX = Math.sin(x);
////                        append(Qt.point(x, sinX));
////                    }
////                }

////                property int offset: 100;

////                Rectangle {
////                    color: Qt.rgba(1, 1, 1, 0.7)
////                    radius: 10
////                    border.width: 1
////                    border.color: "white"
////                    anchors.fill: label
////                    anchors.margins: -10
////                }

////                Text {
////                    id: label
////                    color: "black"
////                    wrapMode: Text.WordWrap
////                    text: "The background here is a squircle rendered with raw OpenGL using the 'beforeRender()' signal in QQuickWindow. This text label and its border is rendered using QML"
////                    anchors.right: parent.right
////                    anchors.left: parent.left
////                    anchors.bottom: parent.bottom
////                    anchors.margins: 20
////                }
////            }

//////            Timer {
//////                id: timer
//////                interval: 500
//////                repeat: true
//////                running: true
//////                onTriggered: {
////////                    graph.removeFirstSample();
////////                    graph.appendSample(graph.newSample(++graph.offset));
//////                    graph.update();
//////                }

//////            }

//////            Rectangle {
//////                anchors.fill: graph
//////                color: "transparent"
//////                border.color: "black"
//////                border.width: 2
//////            }

////        }

////    }
//}

Item {
    height: 600

ListView {
    id: flickable

    anchors.fill: parent
    anchors.margins: 20

//    height: 750

    orientation: ListView.Horizontal

    clip: true

    model: 5

    delegate: numberDelegate2
    spacing: 5

    ScrollBar.horizontal: ScrollBar {
//        size: 1
        contentItem: Rectangle {
            width: 50
//             implicitWidth: 600
             implicitHeight: 30
//             radius: width / 2
             color: "black"
         }
        background: Rectangle {
//            implicitWidth: 100
//            implicitHeight: 40
//            opacity: enabled ? 1 : 0.3
            color: "blue"
        }

//        parent: flickable.parent
//        anchors.top: flickable.top
//        anchors.left: flickable.right
//        anchors.bottom: flickable.bottom
    }

//    onVisibleAreaChanged: {
//        console.log("onVisibleAreaChanged: "+ visibleChildren.length)
//        for (var i = 0; i < visibleChildren.length; ++i)
//        {
//            console.log(i +": "+ visibleChildren[i].objectName)
//        }
//    }

    function updateNDC()
    {
        for (var i = 0; i < contentItem.visibleChildren.length; ++i)
        {
            var visibleChild = contentItem.visibleChildren[i]
            console.log(i +": "+ visibleChild.objectName)

            for (var j = 0; j < visibleChild.children.length; ++j)
            {
                var child = visibleChild.children[j]
                console.log(j +": "+ child)

                if (child.objectName === "graph")
                    child.updateNDC()

                child = null
            }

            visibleChild = null
        }
    }

    visibleArea.onWidthRatioChanged: {
//        console.log("visibleArea.onWidthRatioChanged: {"+ contentItem.visibleChildren.length)
//        for (var i = 0; i < contentItem.visibleChildren.length; ++i)
//        {
//            console.log(i +": "+ contentItem.visibleChildren[i].objectName)
//        }
        updateNDC()
    }

    visibleArea.onXPositionChanged: {
        updateNDC()
    }

    Component.onCompleted: {
//        visibleArea.widthRatio.connect(myOn)
    }

    function myOn()
    {
        console.log("onVisibleAreaChanged: "+ visibleChildren.length)
        for (var i = 0; i < visibleChildren.length; ++i)
        {
            console.log(i +": "+ visibleChildren[i].objectName)
        }
    }

//    onVisibleChildrenChanged: {
//        console.log("onVisibleChildrenChanged: "+ visibleChildren.length)
//        for (var i = 0; i < visibleChildren.length; ++i)
//        {
//            console.log(i +": "+ visibleChildren[i].objectName)
//        }
//    }
}

Component {
    id: numberDelegate

    Rectangle {

        color: "green"

        objectName: "graphContainer"

        width: 300
        height: 400

        Text {
            anchors.centerIn: parent
            text: index
        }
    }
}

Component {
    id: numberDelegate2

    Item {


        objectName: "graphContainer"

        width: 300
        height: 800

        property point mLastPosition: Qt.point(-1, -1)

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (mouse.buttons === Qt.RightButton)
                    graph.resetVP()
            }

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

                graph.shiftScene(parent.mLastPosition.x - mouse.x,
                                 parent.mLastPosition.y - mouse.y)

                parent.mLastPosition = Qt.point(mouse.x, mouse.y);
            }
        }

        Graph {
            id: graph
            anchors.fill: parent
            anchors.margins: 0
            clip: true

            objectName: "graph"

            function newSample(i) {
                return (Math.sin(i / 100.0 * Math.PI * 2) + 1) * 0.4 + Math.random() * 0.05;
            }

            Component.onCompleted: {
                //                    for (var i=0; i<100; ++i)
                //                        appendSample(newSample(i));

                var stepCount = 100;
                var leftLimit = -20;
                var rightLimit = 10;

                for (var i = 0; i <= stepCount; ++i)
                {
                    const factor = i / stepCount;
                    var oneMinusFactor = (stepCount - i) / stepCount;

                    var x = leftLimit * oneMinusFactor + rightLimit * factor;
                    var sinX = Math.sin(x);
                    append(Qt.point(x, sinX));
                }
            }

            property int offset: 100;

            Rectangle {
                color: Qt.rgba(1, 1, 1, 0.7)
                radius: 10
                border.width: 1
                border.color: "white"
                anchors.fill: label
                anchors.margins: -10
            }

            Text {
                id: label
                color: "black"
                wrapMode: Text.WordWrap
                text: "(" + index + ") The background here is a squircle rendered with raw OpenGL using the 'beforeRender()' signal in QQuickWindow. This text label and its border is rendered using QML"
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.margins: 20
            }
        }

        //            Timer {
        //                id: timer
        //                interval: 500
        //                repeat: true
        //                running: true
        //                onTriggered: {
        ////                    graph.removeFirstSample();
        ////                    graph.appendSample(graph.newSample(++graph.offset));
        //                    graph.update();
        //                }

        //            }

        //            Rectangle {
        //                anchors.fill: graph
        //                color: "transparent"
        //                border.color: "black"
        //                border.width: 2
        //            }

    }
}
}
