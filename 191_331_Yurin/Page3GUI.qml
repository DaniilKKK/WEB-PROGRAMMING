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

    //Юрин Даниил. В списке 25. Вариант 3
    GridLayout{
        id: gridLayout
        anchors.fill: parent
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        rows: 1
        columns: 3
        anchors.leftMargin: 15
        anchors.rightMargin: 15

        Label {
        Layout.column: 0
         Layout.row: 0
          text: "Регистрация пользователя"
          anchors.top: parent.top
          font.pointSize: 13
          font.weight: Font.Bold //шрифт жирный
          anchors.topMargin: 20

          anchors.horizontalCenter: parent.horizontalCenter
                }
}
   GridLayout {
        id: gridLayout1
        anchors.fill: parent
        anchors.bottomMargin: 6
        anchors.topMargin: -6
        //rows: 5
        //columns: 3
        anchors.leftMargin: 15 //сделал отступы по бокам
        anchors.rightMargin: 15

        Label {
          id: personal_data


          Layout.row: 1     //добавил в 1 колонку 1 строки
          Layout.column: 1

          anchors.left: parent.left
          horizontalAlignment: Text.AlignHCenter  //расположил по центру Layout coloumn
          verticalAlignment: Text.AlignTop
          anchors.leftMargin: 0
          anchors.right: control5.left
          font.weight: Font.Bold //задал стиль шрифту
          font.pointSize: 9

          text: "Введите ФИО и возраст:"
                }

         TextArea {
             id: control5

             Layout.row: 1      //добавил в 2 колонку 1 строки
             Layout.column: 2

             color: "#ff0000"
             horizontalAlignment: Text.AlignHCenter
             placeholderText: "Введите ФИО"
             background: Rectangle {
                 implicitWidth: 200
                 implicitHeight: 40
                 border.color: control5.enabled ? "#21be2b" : "transparent"
                   }
         }
             Tumbler {
                 Layout.row: 1          //добавил в 3 колонку 1 строки
                 Layout.column: 3
                 anchors.right: parent.right
                 anchors.rightMargin: 8
                 id: control4

                 model: 15

                 background: Item {
                     Rectangle {
                         opacity: control4.enabled ? 0.2 : 0.1
                         border.color: "#21be2b"
                         width: parent.width
                         height: 1
                         anchors.top: parent.top
                     }

                     Rectangle {
                         opacity: control4.enabled ? 0.2 : 0.1
                         border.color: "#21be2b"
                         width: parent.width
                         height: 1
                         anchors.bottom: parent.bottom
                     }
                 }

                 delegate: Text {
                     text: qsTr(" %1 Лет").arg(modelData + 1) //изменил "Item" на "лет"
                     font: control4.font
                     horizontalAlignment: Text.AlignHCenter
                     verticalAlignment: Text.AlignVCenter
                     opacity: 1.0 - Math.abs(Tumbler.displacement) / (control4.visibleItemCount / 2)
                 }

                 Rectangle {
                     anchors.horizontalCenter: control4.horizontalCenter
                     y: control4.height * 0.4
                     width: 40
                     height: 1
                     color: "#ff0000"
                 }

                 Rectangle {
                     anchors.horizontalCenter: control4.horizontalCenter
                     y: control4.height * 0.6
                     width: 40
                     height: 1
                     color: "#ff0000"
                 }

             }



             Label {
               id: pasport_data

               width: 266
               height: 19

               Layout.row: 2     //добавил в 1 колонку 2 строки
               Layout.column: 1

               anchors.left: parent.left
               anchors.leftMargin: 0
               anchors.top: personal_data.bottom
               anchors.topMargin: 30
               font.weight: Font.Bold //задал стиль шрифту
               font.pointSize: 9

               text: "Введите серию и номер паспорта:"
                     }



        TextField {
            Layout.column:2 //добавил в 2 колонку 2 строки
            Layout.row:2
            id: control
            color: "#ff0000"
            width: 200
            height: 48
            horizontalAlignment: Text.AlignHCenter
            anchors.top: control5.bottom
            anchors.topMargin: 5
            placeholderText: qsTr("Введите серию и номер паспорта")

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: control.enabled ? "transparent" : "#353637"
                border.color: control.enabled ? "#21be2b" : "transparent"

            }

            Dial {
                        Layout.row: 3     //добавил в 2 колонку 3 строки
                        Layout.column: 2
                        id: control1
                        anchors.top: control.bottom
                        transformOrigin: Item.Center  //располодил снизу под элементом control1
                        anchors.topMargin: 5
                        anchors.leftMargin: 10
                        background: Rectangle {
                            x: control1.width / 2 - width / 2
                            y: control1.height / 2 - height / 2
                            width: Math.max(64, Math.min(control1.width, control1.height))
                            height: width
                            color: "transparent"
                            radius: width / 2
                            border.color: control1.pressed ? "#17a81a" : "#21be2b"
                            opacity: control1.enabled ? 1 : 0.3
                        }

                        handle: Rectangle {
                            id: handleItem
                            x: control1.background.x + control1.background.width / 2 - width / 2
                            y: control1.background.y + control1.background.height / 2 - height / 2
                            width: 16
                            height: 16
                            color: control1.pressed ? "#17a81a" : "#21be2b"
                            radius: 8
                            antialiasing: true
                            opacity: control1.enabled ? 1 : 0.3
                            transform: [
                                Translate {
                                    y: -Math.min(control1.background.width, control1.background.height) * 0.4 + handleItem.height / 2
                                },
                                Rotation {
                                    angle: control1.angle
                                    origin.x: handleItem.width / 2
                                    origin.y: handleItem.height / 2
                                }
                            ]
                        }
                    }

            BusyIndicator {
                        Layout.row: 3       //расположил в 3 строке и 2 столбец
                        Layout.column: 2
                        id: control2
                        anchors.left:control1.right  //располодил снизу под элементом control и правее элемента control1
                        anchors.top:control.bottom
                        anchors.topMargin: 15
                        anchors.leftMargin: 20
                        contentItem: Item {
                            implicitWidth: 64
                            implicitHeight: 64

                            Item {
                                id: item1
                                x: parent.width / 2 - 32
                                y: parent.height / 2 - 32
                                width: 64
                                height: 64
                                opacity: control2.running ? 1 : 0

                                Behavior on opacity {
                                    OpacityAnimator {
                                        duration: 250
                                    }
                                }

                                RotationAnimator {
                                    target: item1
                                    running: control2.visible && control2.running
                                    from: 0
                                    to: 360
                                    loops: Animation.Infinite
                                    duration: 1250
                                }

                                Repeater {
                                    id: repeater
                                    model: 6

                                    Rectangle {
                                        x: item1.width / 2 - width / 2
                                        y: item1.height / 2 - height / 2
                                        implicitWidth: 10
                                        implicitHeight: 10
                                        radius: 5
                                        color: "#21be2b"
                                        transform: [
                                            Translate {
                                                y: -Math.min(item1.width, item1.height) * 0.5 + 5
                                            },
                                            Rotation {
                                                angle: index / repeater.count * 360
                                                origin.x: 5
                                                origin.y: 5
                                            }
                                        ]
                                    }
                                }
                            }
                        }
                    }

            Label
            {
                Layout.row: 3
                Layout.column: 1
                id: sector_data
                text: "Выбирете сектор и место"
                width: 266
                height: 19
                anchors.top: control.bottom
                anchors.right: control1.left
                anchors.topMargin: 30
                font.weight: Font.Bold //задал стиль шрифту
                font.pointSize: 9
            }

            ProgressBar {
                Layout.row: 3
                Layout.column: 1
                id: control3
                anchors.top: sector_data.bottom
                anchors.right: control1.left
                anchors.topMargin: 30
                anchors.rightMargin: 65
                value: 0.5
                padding: 2

                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 6
                    color: "#e6e6e6"
                    radius: 3
                }

                contentItem: Item {
                    implicitWidth: 200
                    implicitHeight: 4

                    Rectangle {
                        width: control.visualPosition * parent.width
                        height: parent.height
                        radius: 2
                        color: "#17a81a"
                    }
                }
            }
        }

        //закрытие GridLayout


}

}




