import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4

Item {

    function switchStarredState(){
        for( var i = 0; i < view.count; i++ ){
            if( view.itemAtIndex(i).amIStar ){
                 view.itemAtIndex(i).switchState()
            }
        }
    }

    Rectangle {
        id: rect
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: parent.height / 12
        color: Qt.lighter("#373b37", 2)
        z: 2

        property int iconWidth: window.width / 25
        property int iconHeight: window.height / 20

        Row {
            anchors.centerIn: parent
            Image {
                id: add
                width: rect.iconWidth
                height: rect.iconHeight
                source: 'qrc:/image/add.png'
                MouseArea {
                    id: addMa
                    anchors.fill: parent
                    onPressed: parent.opacity = 0.5
                    onReleased: parent.opacity = 1
                    onClicked: myModel.addData()
                }
            }

            Image {
                id: remove
                width: rect.iconWidth
                height: rect.iconHeight
                source: 'qrc:/image/delete.png'
                MouseArea {
                    id: removeMa
                    anchors.fill: parent
                    onPressed: parent.opacity = 0.5
                    onReleased: parent.opacity = 1
                    onClicked: myModel.removeStarredData();
                }
            }

            Image {
                id: hide
                width: rect.iconWidth
                height: rect.iconHeight
                source: 'qrc:/image/eye.png'
                MouseArea {
                    id: hideMa
                    anchors.fill: parent
                    onPressed: parent.source = 'qrc:/image/hide.png'
                    onReleased: parent.source = 'qrc:/image/eye.png'
                    onClicked: switchStarredState()
                }
            }
        }
    }
    Rectangle{
        color: Qt.lighter("#373b37", 2)
        anchors {
            top: rect.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        ListView {
            id: view
            spacing: 5
            anchors.fill: parent
            model: myModel
            delegate: DropDown {
                elapsedText: elapsedTime
                currentText: currentTime
                bWidth: rect.iconWidth / 1.5
                bHeight: rect.iconHeight
                anchors {
                    left: (parent ? parent.left : undefined)
                    right: (parent ? parent.right : undefined)
                }
            }
        }
    }

}
