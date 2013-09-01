import QtQuick 2.0
import QtGraphicalEffects 1.0
import "login.js" as Login

Item {
    id: pageLogin

//    Rectangle {
//        id: logo
//        width: 310
//        height: 100
//        border.color: "gray"

//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.top: parent.top
//        anchors.topMargin: 100

//        //replace this with logo image
//        Text {
//            text: "LOGO"
//            font.family: "Helvetica"
//            font.pointSize: 80
//            color: "#030303"
//        }
//    }

    Rectangle {
        //width: 310
        //height: 100
        anchors.fill: parent
        //border.color: "gray"
        color: "#2A80B9"

        //anchors.horizontalCenter: parent.horizontalCenter
        //anchors.top: logo.bottom
        //anchors.topMargin: 50

//        Component.onCompleted:
//        {
//            //keyfobInputText.forceActiveFocus()
//        }

//        Text {
//            text: "Tap Your Keyfob for Loginzzz"
//            font.family: "Helvetica"
//            font.pointSize: 15
//            color: "#030303"
//        }

        TextInput {
            visible: false
            id: keyfobInputText
            text: ""//activeFocus ? "I have active focus!" : "I do not have active focus"
            width: 100
            height: 20
            anchors.bottom: parent.bottom
            focus: true
            font.pointSize: 20

            //TODO establish time limit for key punches so that entered text
            //from the keyboard doesn't stay around and get sent with keyfob
            Keys.onReturnPressed: {
                //console.log("entereddkdkdkdkdkd")
                //pageLoad.source = "pageCustomers.qml";
                blink.visible = true;
                //console.log("entereddkdkdkdkdkd222")
                blinkTimer.running = true;
                Login.login(keyfobInputText.text);
                keyfobInputText.text = "";
            }
        }
        Image {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "Toasty_LOGIN_green.jpg"
        }

        StyledText {
            id: customerError
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 402

            //text: "Sorry :( It looks like you've already tanned today."
            font.pixelSize: 35
            font.bold: true
            color: "white"

        }

        Rectangle {
            id: blink
            width: 31
            height: width
            color: "red"
            radius: width*0.5
            antialiasing: true
            visible: false

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 182
            anchors.leftMargin: 611
        }

        Timer {
            interval: 1000
            running: false
            //repeat: true
            onTriggered: {
                blink.visible = true;
                blinkTimer.running = true;
            }
        }


        Timer {
            id: blinkTimer
            interval: 500
            running: false
            //repeat: true
            onTriggered: {
                blink.visible=(!blink.visible);
            }
        }

        Timer {
            id: errTimer
            interval: 4000
            running: false
            onTriggered: {
                customerError.visible = false;
            }
        }
    }
}

