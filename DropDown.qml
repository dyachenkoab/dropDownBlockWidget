import QtQuick 2.0
import QtQuick.Controls 2.14

Rectangle{
    property alias text: textItem.text
    property alias loader: loader
    property alias source: loader.source
    property int myId
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
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        newDropDown()
                    }
                }
            }
            Button {
                id: slide
                width: 30
                height: 30
                anchors.left: butt.right
                anchors.leftMargin: 5
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        container.visible = !container.visible
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
