import QtQuick 2.0
import QtGraphicalEffects 1.0
import "minutes.js" as Minutes

Item {
    Rectangle {
        id: backButton
        width: 200
        height: 95
        color: "#9AC7E6"

        MultiPointTouchArea {
            anchors.fill: parent

            onPressed: { pageLoad.source = "pageBeds.qml" }
        }

        StyledText {
            id: back
            font.bold: true
            font.pixelSize: 30
            font.letterSpacing: -1

            anchors.centerIn: parent

            text: "BACK"
        }
    }

    StyledText {
        font.pixelSize: 30

        anchors.left: backButton.right
        anchors.leftMargin: 20
        anchors.bottom: backButton.bottom
        anchors.bottomMargin: -6

        //TODO This adds about 10% CPU usage on constant swiping. Fix it
        text: {"BED " + mainWindow.bedSelected + "\n" + mainWindow.bedName}
    }

    Rectangle {
        id: toucher
        anchors.top: backButton.bottom
        anchors.topMargin: 60

        width: 1250
        height: 300

        MultiPointTouchArea {
            anchors.fill: parent

            onUpdated: {Minutes.updateSlider()}

            touchPoints: [
                TouchPoint { id: point1 }
            ]
        }

        Row {
            id: minutes

           // property double colorStep:{0.376/(mainWindow.maxTime-1)}
            property double colorStep:{0.55/(mainWindow.maxTime-1)}
            property double mWidth:{{1250/(mainWindow.maxTime-1)}}
            property int selected: -1

            Repeater {
                model: mainWindow.maxTime - 1

                Rectangle {
                    width: minutes.mWidth
                    height: 300
                    color: "#9AC7E6"
                    border.color: "#3E3E3E"
                    border.width: 2

                    property alias orange: orangeButton.visible

                    Rectangle {
                        id: orangeButton
                        width: minutes.mWidth
                        height: 300
                        color: {
                            Qt.rgba(1, (0.647 - (index*minutes.colorStep)), 0, 1)
                        }
                        border.color: "#3E3E3E"
                        border.width: 2
                        visible: false
                    }

                    StyledText{
                        anchors.centerIn: parent
                        font.pixelSize: 40
                        font.bold: true

                        text: index + 2
                    }
                }
            }
        }
    }

    RectangularGlow {
        id: effect
        anchors.fill: start
        glowRadius: 10
        spread: 0.0
        color: "white"
        cornerRadius: start.radius + glowRadius
        antialiasing: true
        visible: false
    }

    Rectangle {
        id: start
        width: 1250
        height: 200
        radius: 5
        antialiasing: true
        border.color: "#3E3E3E"
        border.width: 2
        color: "#4AB848"

        anchors.top: toucher.bottom
        anchors.topMargin: 40

        StyledText {
            id: sessionText
            font.pixelSize: 50
            anchors.centerIn: parent
        }

//        MultiPointTouchArea {
//            id: startTouch
//            anchors.fill: parent

//            onPressed: {pageLoad.source="pageLogin.qml"}
//        }
        MultiPointTouchArea {
            id: startTouch
            visible: false
            anchors.fill: parent

            onPressed: {Minutes.startBed()}

            Timer {
                id: timer
                interval: 2500
                running: false
                repeat: false

                onTriggered: {
                    pageLoad.source="pageLogin.qml"
                }
            }
        }
    }

    Rectangle {
        id: footer
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -15
        anchors.horizontalCenter: parent.horizontalCenter
        width: 1240
        height: 35
        color: "#2A2A2A"
    }

    Rectangle {
        id: gray
        anchors.centerIn: parent
        width: 1280
        height: 800
        opacity: .5
        color: "white"
        visible: false

        MouseArea {
            anchors.fill: parent
        }
    }

    Rectangle {
        id: popup
        anchors.centerIn: parent
        width: 700
        height: 200
        color: "gray"
        radius: 10
        antialiasing: true
        visible: false;

        StyledText {
            id: popupText
            anchors.centerIn: parent
            font.pixelSize: 40
            font.bold: true

            //TODO Add bed indicator
            text: "Bed will start in 15 minutes"
        }
    }
}
