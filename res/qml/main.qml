import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    id: window
    width: 800
    height: 600
    visible: true
    title: qsTr("Hello World")

    Control {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: space.left
        anchors.left: parent.left
    }

    Rectangle {
        id: space
        color: 'green'
        opacity: 0.5
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: parent.width / 1.2
    }

}
