import QtQuick 2.0
//import QtQuick.Window 2.0

//Change to window later
Item {
    id: mainWindow
    //title: "Toasty Customer UI"
    width: 1280
    height: 800

    property string name: "Greg von Snoot"
    property int level: 3
    property int id
    property int bedSelected: 1
    property int minutesSelected
    property string bedName: "SUNDASH 232"
    property int maxTime: 20

    Rectangle {
        anchors.fill: parent
        color: "#2A80B9"

        Loader {
            id: pageLoad
            focus: true //loader must have focus: true in order for children to have focus
            source: "pageLogin.qml"
            //source: "pageMinutes.qml"
            anchors.fill: parent
            anchors.margins: 15
        }
    }
}
