import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0


Page {
    id: page3GUI


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


    GridLayout{
        anchors.topMargin: 77
        anchors.fill: parent
        columns: 2
        rows: 6



            Layout.row: 1
            Layout.column: 0
            Layout.alignment: Qt.AlignCenter

            width: 200
            height:150



            Image {
                id: bug
                source: "sobaka.jpg"
                width: 200
                height:150
                smooth: true
                visible: false
            }

            Image {
                id: mask
                source: "ThresholdMask_mask.png"
                width: 200
                height:150
                smooth: true
                visible: false
            }

            ThresholdMask {
                anchors.fill: bug
                source: bug
                maskSource: mask
                threshold: slider1.value
                spread: slider2.value
            }






        ColumnLayout{
            Layout.row: 1
            Layout.column: 1

            Rectangle {
                id: rectangle33
                width: 100
                height: 20
                color: "#ffab25"
                radius: 10
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


                Label {
                    id: label13
                    width: 74
                    height: 13
                    color: "#000000"
                    text: qsTr("ThresholdMask")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }


            Slider {
                id: slider1
                Text {

                    color: "#ffab25"

                    text: qsTr("threshold")
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                from: 0.0
                to: 1.0
                value: 0.5

            }
            Slider{
                id: slider2
                Text {

                    color: "#ffab25"

                    text: qsTr("spread")
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                from: 0.0
                to: 1.0
                stepSize: 0.2

            }
        }

        Rectangle{
            Layout.row: 2
            Layout.columnSpan: 2
            color: "#ffab25"

            height: 2
            Layout.fillWidth: true
            radius: 0

        }


        Item {
            width: 200
            height: 150
            Layout.row: 3
            Layout.column: 0
            Layout.alignment: Qt.AlignCenter


            Rectangle {
                anchors.fill: parent
            }

            Image {
                id: bug2
                source: "sobaka.jpg"
                width: 200
                height: 150
                smooth: true
                visible: false

            }

            BrightnessContrast {
                anchors.fill: bug2
                source: bug2
                brightness: slider4.value
                contrast: slider5.value
            }
        }

        ColumnLayout{
            Layout.row: 3
            Layout.column: 1

            Rectangle {
                id: rectangle34
                width: 100
                height: 20
                color: "#ffab25"
                radius: 10
                Layout.fillWidth: false
                Label {
                    id: label34
                    width: 84
                    height: 13
                    color: "#000000"
                    text: qsTr("BrightnessContr")
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Slider {
                id: slider4
                Text {

                    color: "#ffab25"

                    text: qsTr("brightness")
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                from: 0.0
                to: 1.0
                stepSize: 0.1

            }
            Slider {
                id: slider5
                Text {

                    color: "#ffab25"

                    text: qsTr("contrast")
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                from: 0.0
                to: 1.0
                stepSize: 0.1

            }

        }

        Rectangle{
            Layout.row: 4
            Layout.columnSpan: 2
            color: "#ffab25"

            height: 2
            Layout.fillWidth: true
            radius: 0


        }

        Item {
            width: 200
            height: 150
            Layout.row: 5
            Layout.column: 0
            Layout.alignment: Qt.AlignCenter



            Image {
                id: bug1
                source: "sobaka.jpg"
                width: 200
                height: 150
                smooth: true
                visible: false

            }

            Image {
                id: mask1
                source: "mask1.png"
                width: 200
                height: 150
                smooth: true
                visible: false
            }

            OpacityMask {
                anchors.fill: bug1
                source: bug1
                maskSource: mask1
                invert: invert.checked

            }
        }

        ColumnLayout{
            Layout.row: 5
            Layout.column: 1
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: false
            Layout.fillWidth: false


            Rectangle {
                id: rectangle35
                width: 100
                height: 20
                color: "#ffab25"
                radius: 10
                Layout.fillWidth: false
                Label {
                    id: label35
                    width: 62
                    height: 13
                    color: "#000000"
                    text: qsTr("OpacityMask")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Switch{
                id:invert
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            }


        }
    }

}




