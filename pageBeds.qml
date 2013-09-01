import QtQuick 2.0
import "beds.js" as Beds

Item {
    Row {
        id: tabs
        anchors.left: parent.left
        spacing: 10

        property int tabIndex

        Repeater {
            //setting model to an int x calls the repeater x times
            model: {mainWindow.level}

            Rectangle {
                id: tab
                width: 200
                height: 95
                color: "#56A2D6"

                StyledText {
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true

                    text: "LEVEL " + (index+1)
                }

//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        Beds.tabPressed(index)
//                    }
//                }

                MultiPointTouchArea {
                    anchors.fill: parent

                    onPressed: {Beds.tabPressed(index)}
                }

            }
        }

        //levl-1 b/c tabPressed expects 0 indexed tabs, & levels arent
        Component.onCompleted: Beds.tabPressed(mainWindow.level-1)
    }

    Grid {
        anchors.top: tabs.bottom
        anchors.topMargin: 40

        columns: 5
        rows: 2
        spacing: 10

        Repeater {
            id: beds
            //model: 10

            Rectangle {
                width: 242
                height: 242
                color: "#FFFFFF"

                property int bedNum: beds.model[index]["Bed_num"]

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 50

                    source: "bed_icon.png"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 81

                    font.family: "Arial"
                    font.pixelSize: 45
                    font.bold: true
                    color: "#2A2A2A"

                    text: bedNum
                }

                StyledText {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 25


                    text: beds.model[index]["Name"].toUpperCase()
                }

//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        console.log("clickeeeed"+ bedNum)
//                        mainWindow.bedSelected = bedNum
//                        mainWindow.maxTime = beds.model[index]["Max_time"]
//                        mainWindow.bedName = beds.model[index]["Name"]
//                        pageLoad.source = "pageMinutes.qml"
//                    }
//                }

                MultiPointTouchArea {
                    anchors.fill: parent
                    onPressed: {
                        console.log("clickeeeed"+ bedNum)
                        mainWindow.bedSelected = bedNum
                        mainWindow.maxTime = beds.model[index]["Max_time"]
                        mainWindow.bedName = beds.model[index]["Name"]
                        pageLoad.source = "pageMinutes.qml"
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    color: "red"
                    opacity: 0.6

                    visible: (!beds.model[index]["Status"])

                    MouseArea {
                        anchors.fill: parent//keeps people from pressing beds
                        //when not active
                    }
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

    Text {
        anchors.bottom: footer.top
        anchors.bottomMargin: -22
        anchors.right: footer.right
        anchors.rightMargin: 10
        font.family: "Arial"
        font.pixelSize: 60
        font.bold: true
        font.letterSpacing: -3
        color: "#2A2A2A"

        text: mainWindow.name
    }
}







