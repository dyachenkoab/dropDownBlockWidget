import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.14

Rectangle{
    property alias elapsedText: elapsedText.text
    property alias currentText: currentText.text
    property bool amIStar: myModel.getAmIStar(index)

    property int bWidth
    property int bHeight

    property bool isOpen: false

    function switchState(){
        container.visible = !container.visible
        isOpen = !isOpen
    }

    height: container.visible ? columns.height + 5 : header.height
    color: "#373b37"
    clip: true

    Column {
        id: columns
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        Rectangle {
            id: header
            x: 5
            height: bHeight
            color: '#373b37'
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: 5
            }
            Text {
                id: elapsedText
                color: 'white'
                font.pixelSize: bHeight / 2
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
            }
            Image {
                id: starButton
                source: 'qrc:/image/star.png'
                width: bWidth
                anchors {
                    left: elapsedText.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: 5
                }
                layer.enabled: (amIStar ? true : false)
                layer.effect: Glow {
                    anchors.fill: starButton
                    radius: 5
                    samples: 10
                    color: "lightblue"
                    source: starButton
                    transparentBorder: true
                }
                MouseArea {
                    id: starButtonMa
                    anchors.fill: parent
                    onClicked: amIStar = myModel.changeStar(index)
                }
            }

            Image {
                id: slideButton
                width: bWidth
                source: 'qrc:/image/arrow.png'
                property int angleT: (isOpen ? -90 : 90)
                transform: Rotation {
                    origin.x: slideButton.width / 2
                    origin.y: slideButton.height / 2
                    angle: slideButton.angleT
                }
                anchors {
                    left: starButton.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: 5
                }
                MouseArea {
                    id: slideButtonMa
                    anchors.fill: parent
                    onClicked: switchState()
                }
                Behavior on angleT {
                    NumberAnimation { duration: 1000 }
                }
            }
        }

        Rectangle{
            id: container
            visible: false
            color: Qt.lighter("#373b37", 1.2)
            height: containerItem.height + 10
            anchors {
                left: parent.left
                right: parent.right
                margins: 5
            }
            Item {
                id: containerItem
                width: parent.width
                height: bHeight * 5
                visible: true
                Text {
                    id: currentText
                    anchors.centerIn: parent
                    font.pixelSize: bHeight / 2
                    color: 'white'
                }

            }
        }

    }
    Behavior on height {
        NumberAnimation { duration: 1000 }
    }

}
