import QtQuick 2.0

Item {
    id: consoleItem
    width: parent.width
    height: 150
    visible: true

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: time.text = Date().toString()
    }

    Text {
        id: time
        anchors.centerIn: parent
    }

}
