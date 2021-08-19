import QtQuick 2.0
//import QtQuick.Controls 2.14
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4

Rectangle{
    property alias text: textItem.text
    property alias loader: loader
    property alias source: loader.source
    property int myId
    property bool amIStar: false
    signal newDropDownSignal()

    height: container.visible ? columns.height + 5 : 30
    anchors { left: parent.left; right: parent.right }
    color: "#53d769"
    clip: true

    Column{
        id: columns
        anchors.left: parent.left
        anchors.right: parent.right
        Rectangle {
            id: header
            x: 5
            height: 30
            anchors.left: parent.left
            anchors.right: parent.right
            color: "#53d769"
            Text {
                id: textItem
                anchors.left: parent.left
                verticalAlignment: Text.AlignVCenter
            }
            Button {
                id: butt
                width: 30
                height: 30
                anchors.left: textItem.right
                anchors.leftMargin: 5
                onClicked: amIStar = !amIStar
                style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 25
                        border.width: slide.activeFocus ? 2 : 1
                        border.color: "black"
                        color: 'white'
                        radius: 4
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: amIStar ? "red" : "yellow"; }
                            GradientStop { position: 1 ; color: amIStar ? "yellow" : "red" }
                        }
                    }
                }
            }

            Button {
                id: slide
                width: 30
                height: 30
                anchors.left: butt.right
                anchors.leftMargin: 5
                onClicked: container.visible = !container.visible
                style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 25
                        border.width: slide.activeFocus ? 2 : 1
                        border.color: "black"
                        color: 'white'
                        radius: 4
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: slide.pressed ? "white" : "black"; }
                            GradientStop { position: 1 ; color: slide.pressed ? "black" : "white" }
                        }
                    }
                }
            }

        }
        Rectangle{
            id: container
            visible: false
            color: Qt.darker("#53d769", 1.2)
            anchors { left: parent.left; right: parent.right; margins: 5}
            height: loader.height + 10
            Loader{
                y: 5
                anchors { left: parent.left; right: parent.right; margins: 5}
                id: loader
            }
        }

    }
    Behavior on height {
        NumberAnimation { duration: 1000 }
    }

}
