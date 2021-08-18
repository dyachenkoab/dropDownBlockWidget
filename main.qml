import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    property int i: 0

    function newDropDown() {
        var imgObj = Qt.createComponent("DropDown.qml");
        if (imgObj.status === Component.Ready){
            var k = imgObj.createObject(curr, {text: '123', myId: i++, source: "ItemComboBox.qml"})
        }
    }

    Item {
        //виджет, на котором есть блок кнопок
    }

    Item {
        id: curr
        anchors.fill: parent
        Component.onCompleted: {
            var imgObj = Qt.createComponent("DropDown.qml");
            if (imgObj.status === Component.Ready){
                var k = imgObj.createObject(curr, {text: '123', myId: i++, source: "ItemComboBox.qml"})
            }

//          for(var g = 0; g < curr.children.length; g++){
//                  console.log(curr.children[g].myId)
//              if( curr.children[g].myId === 1 ){
//                  console.log(curr.children[g].loader.item)
//                  curr.children[g].loader.item.tableModel.append({'sensor': 'Fire sensor'})
//              }
//          }
        }
    }

}
