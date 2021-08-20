import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    property int i: 0

    function switchState(){
        for( var i = 0; i < view.count; i++ ){
            if( view.itemAtIndex(i).amIStar ){
                 view.itemAtIndex(i).switchState()
            }
        }
    }

    Rectangle {
        //виджет, на котором есть блок кнопок
        id: rect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 50
        Button {
            id: add
            width: 30
            height: 30
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            text: 'a'
            style: ButtonStyle {
                background: Rectangle {
                    border.width: add.activeFocus ? 2 : 1
                    border.color: "black"
                    color: 'white'
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: add.pressed ? "white" : "black"; }
                        GradientStop { position: 1 ; color: add.pressed ? "black" : "white" }
                    }
                }
            }
            onClicked: myModel.addData()
        }

        Button {
            id: remove
            width: 30
            height: 30
            anchors.left: add.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            text: 'r'
            onClicked: {
                myModel.removeStarredData();
            }
        }

        Button {
            id: hide
            width: 30
            height: 30
            anchors.left: remove.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            text: 'h'
            onClicked: switchState()
        }
    }

    Column {
        id: curr
        anchors.top: rect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: 5
    }
    Item {
        anchors.top: rect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        ListView {
            id: view
             anchors.fill: parent
             model: myModel
             delegate: DropDown {
                 text: elapsedTime
                 time: currentTime
             }
        }
    }

}
