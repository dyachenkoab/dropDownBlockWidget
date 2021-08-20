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

    function newDropDown() {
        var imgObj = Qt.createComponent( "DropDown.qml" );
        if ( imgObj.status === Component.Ready ){
            var k = imgObj.createObject( curr, {text: '123', myId: i++, source: "ItemComboBox.qml"} )
        }
    }

    function acceptToAll( command ){
        for( var g = curr.children.length-1; g >= 0; g-- ){
            if( curr.children[g].amIStar ){
                switch ( command ){
                case 'destroy':
                    curr.children[g].destroy()
                    break
                case 'switchState':
                    curr.children[g].switchState()
                    break
                default:
                    console.log( 'wrong command' )
                }
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
            onClicked: newDropDown()
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
                acceptToAll('destroy')
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
            onClicked: acceptToAll('switchState')
        }
    }

    Column {
        id: curr
        anchors.top: rect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: 5
        Component.onCompleted: {
            newDropDown()

//          for(var g = 0; g < curr.children.length; g++){
//                  console.log(curr.children[g].myId)
//              if( curr.children[g].myId === 1 ){
//                  console.log(curr.children[g].loader.item)
//                  curr.children[g].loader.item.tableModel.append({'sensor': 'Fire sensor'})
//              }
//          }
        }
    }
    Item {
        anchors.top: rect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
       ListView {
            anchors.fill: parent
            model: myModel
            delegate: DropDown {
                text: "Animal: " + elapsedTime + ' ' + currentTime
            }
        }
    }

}
