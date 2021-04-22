import QtQuick 2.12
import QtQml.Models 2.2
import QtQml 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtQuick.Window 2.2
import QtMultimedia 5.12
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

Page{
    id: page4GUI
    header: Rectangle {
        id: lab1_header
        color: "#3c3c3c" //цвет шапки
        height: 115 //высота шапки

        Image {
            id: polytech_label
            source: "https://avatars.mds.yandex.net/get-zen_doc/1546191/pub_5f991ac573193b2ea3b84386_5f991af373193b2ea3b8946b/scale_1200"
            width: 68
            height: 85
            anchors.verticalCenter:  parent.verticalCenter
            anchors.left: parent.left
        }


        Label {
            text: "ФК Локомотив
ОФИЦИАЛЬНЫЙ САЙТ"

            /*leftPadding: 20
            anchors.top:polytech_label.bottom
            anchors.left: parent.left*/
            anchors.verticalCenter: lab1_header.verticalCenter  //выравние текста справа посередине от изображения
            anchors.left: polytech_label.right
            font.weight: Font.Bold //сделал щрифт жирным
            anchors.leftMargin: 10 //задал резмер щрифту
            color: "#ffffff"
        }


        Image {
            id: lang_image
            source: "https://avatars.mds.yandex.net/get-zen_doc/1821029/pub_5ebfcfe3ed526f6abcb9770a_5ebfd05664a20d0122a59ee2/scale_1200"
            width: 45
            height: 25
            anchors.verticalCenter: lab1_header.verticalCenter //расположил флаг по центру относительно шапки и левее относительно
                                                               //Combobox
            anchors.right: control6.left
            anchors.rightMargin: 40
        }


        ComboBox {
            id: control6
            anchors.right: parent.right  //прижал к правому краю, сделал отступ небольшой справа
            anchors.verticalCenter: lab1_header.verticalCenter
            anchors.rightMargin: 10
            model: ["Локомотив", "Купить билеты", "Вход/Выход"]

            delegate: ItemDelegate {
                width: control6.width
                contentItem: Text {
                    text: modelData
                    color: "#21be2b"
                    font: control6.font
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                highlighted: control6.highlightedIndex === index
            }

            indicator: Canvas {
                id: canvas
                x: control6.width - width - control6.rightPadding
                y: control6.topPadding + (control6.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"

                Connections {
                    target: control6
                    function onPressedChanged() { canvas.requestPaint(); }
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = control6.pressed ? "#17a81a" : "#21be2b";
                    context.fill();
                }
            }

            contentItem: Text {
                leftPadding: 0
                rightPadding: control6.indicator.width + control6.spacing

                text: control6.displayText
                font: control6.font
                color: control6.pressed ? "#17a81a" : "#21be2b"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 120
                implicitHeight: 40
                border.color: control6.pressed ? "#17a81a" : "#21be2b"
                border.width: control6.visualFocus ? 2 : 1
                radius: 2
            }

            popup: Popup {
                y: control6.height - 1
                width: control6.width
                implicitHeight: contentItem.implicitHeight
                padding: 1

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: control6.popup.visible ? control6.delegateModel : null
                    currentIndex: control6.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    border.color: "#21be2b"
                    radius: 2
                }
            }
        }
}

    Rectangle {
        id: rectangle122
        color: "#1c7014"
        anchors.topMargin: 0
        anchors.fill: parent
    }
    GridLayout {
        anchors.topMargin: 13
        anchors.fill: parent
        columns: 2




       Label{
           Layout.columnSpan: 2
           anchors.horizontalCenter: parent.horizontalCenter
            Layout.alignment: Qt.AlignCenter
           rightPadding: control.indicator.width + sent.spacing
           text:"Лабораторная работа 4"
           font.weight: Font.Bold
           font.pointSize: 14
           color: "#ff0000"
       }

        Button {
            id: sent
            Layout.alignment: Qt.AlignCenter
            Layout.columnSpan: 2
            onClicked: {
                _send.getNetworkValue();
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Отправить")
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 20
                opacity: enabled ? 1 : 0.3
                color: "#ffab25"
                radius: 10
            }
        }


        ScrollView {
            Layout.fillHeight: true
            Layout.columnSpan: 2

            Layout.fillWidth: true

            clip:  true
            TextArea{
                id: textArea

                textFormat: Text.RichText
                objectName: "textArea"
                readOnly: true
                anchors.fill: parent
                background: Rectangle {
                    color: "white"

                }
            }
        }



    }
}





/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
