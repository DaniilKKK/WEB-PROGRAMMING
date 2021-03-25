import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.12 // для 2 лабы: воспроизведение и запись видео
import QtQuick.Dialogs 1.2 // для "открыть видео" во 2 лабе, пока не реализовано
import QtQuick.Controls.Styles 1.4 // можно менять стили кнопки, но в итоге пока не используется



Page {
    id: page2GUI
    header: Rectangle {
        id: lab1_header
        color: "#3c3c3c" //цвет шапки
        height: 115 //высота шапки

        Image {
            id: polytech_label
            source: "Loko1.png"
            width: 78.5
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

        anchors.bottom: parent.bottom   //прижал сетку GridLayout к стенкам окна
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        columns: 3     //будет 3 колонки и 4 строки
        rows: 4


        RowLayout{
            Layout.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter  //расположил элементы по центру.
            Layout.alignment: Qt.AlignCenter
            //Layout.row:1


            RadioButton {
                id: control
                text: qsTr("Movie")
                checked: true

                indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: control.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    border.color: control.down ? "#17a81a" : "#21be2b"

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: control.down ? "#17a81a" : "#21be2b"
                        visible: control.checked
                    }
                }

                contentItem: Text {
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "#ff0000"
                    verticalAlignment: Text.AlignVCenter

                    leftPadding: control.indicator.width + control.spacing
                }

                onClicked: {
                    columnlay1.visible = true
                    mediaplayer.playbackState === mediaplayer.play()
                    columnlay2.visible=false
                    button.visible=true
                    videoSlider.visible =true
                    volumeSlider.visible=true
                    positionLabel.visible=true
                    camera.stop()
                    buttoncamera.visible=false
                    openButton.visible=true

                }
            }

            Label{
                id:option
                text: "Выберите опцию"
                font.pointSize: 14
                font.family: "Times New Roman"
                leftPadding: control.indicator.width + control.spacing
                rightPadding: control1.indicator.width + control1.spacing

            }

            RadioButton {
                id: control1
                text: qsTr("Camera")
                checked: false

                indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: control1.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    border.color: control1.down ? "#17a81a" : "#21be2b"

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: control1.down ? "#17a81a" : "#21be2b"
                        visible: control1.checked
                    }
                }

                contentItem: Text {
                    font: control1.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "#ff0000"
                    text: "Camera"
                    verticalAlignment: Text.AlignVCenter


                    leftPadding: control1.indicator.width + control1.spacing
                }

                onClicked: {
                    columnlay1.visible = false
                    mediaplayer.playbackState === mediaplayer.pause()
                    columnlay2.visible=true
                    camera.start()
                    button.visible=false
                    videoSlider.visible =false
                    volumeSlider.visible=false
                    positionLabel.visible=false
                    buttoncamera.visible=true
                    openButton.visible=false
                }
            }

        }
        ColumnLayout{
            id:columnlay1
            Layout.topMargin: -30
            Layout.columnSpan: 3
            Layout.row: 1


            MediaPlayer {
                id: mediaplayer
                source: "sample.mp4"
                volume: volumeSlider.volume
            }

            VideoOutput {
                Layout.fillWidth: true
                source: mediaplayer
                id:videooutput

            }

            MouseArea {
                id: playArea
                anchors.fill: parent
                onPressed: mediaplayer.play();
            }

        }
        ColumnLayout{
            id:columnlay2
            visible: false
            Layout.columnSpan: 3
            Layout.row: 1

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight:  true



                Camera {
                    id:  camera
                    captureMode: stop()
                    imageCapture {
                        onImageCaptured: {
                            // показывает превьюху скрина
                            photoPreview1.source = preview
                        }
                    }
                }

                VideoOutput {
                    id: videoCam
                    source:  camera
                    focus :  visible
                    anchors.fill: parent
                }



                Image {
                    Layout.column: 1
                    Layout.row: 0
                    id:  photoPreview1
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 150
                    width: 200
                }
                MouseArea{

                }

            }






        }
        RowLayout{
            Layout.alignment: Qt.AlignCenter

            Layout.columnSpan: 3
            Layout.row: 3
            Button{
                visible: false
                id:buttoncamera
                onClicked: camera.imageCapture.captureToLocation("D:/Balabanova181-331/camera")
                text: "Photo"
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: "#9c27b0"
                    border.color: control.down ? "#9c27b0" : "#9c27b0"
                    border.width: 1
                    radius: 5
                }
            }


        }





        //бегунок
        Slider{
            Layout.columnSpan: 3
            Layout.row: 2
            Layout.fillWidth: true
            id:videoSlider
            to: mediaplayer.duration
            property bool sync: false
            onValueChanged: {
                if (!sync)
                    mediaplayer.seek(value)
            }
            Connections{
                target: mediaplayer
                onPositionChanged: {
                    videoSlider.sync = true
                    videoSlider.value = mediaplayer.position
                    videoSlider.sync = false
                }
            }

        }
        // кнопки плэй и пауза
        Button{

            Layout.margins: 10
            Layout.column: 0
            Layout.row: 3
            id:button
            enabled: mediaplayer.hasVideo
            Layout.preferredWidth: button.implicitHeight
            text: mediaplayer.playbackState === MediaPlayer.PlayingState ? "Stop":"Play"
            onClicked: mediaplayer.playbackState === MediaPlayer.PlayingState ? mediaplayer.pause() : mediaplayer.play()

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                color: "#9c27b0"
                border.color: control.down ? "#9c27b0" : "#9c27b0"
                border.width: 1
                radius: 5
            }
        }
        //слайдер звука
        Slider{
            Layout.column: 1
            Layout.row: 3
            anchors.horizontalCenter: parent.horizontalCenter  //расположил элементы по центру.
            Layout.alignment: Qt.AlignCenter
            id: volumeSlider
            property real volume: QtMultimedia.convertVolume(volumeSlider.value,
                                                             QtMultimedia.LogarithmicVolumeScale,
                                                             QtMultimedia.LinearVolumeScale)
        }


        RowLayout{
            Layout.column: 2
            Layout.row: 3
            Button{


                id: openButton

                text: qsTr("Open")
                Layout.preferredWidth: openButton.implicitHeight
                onClicked: fileDialog.open()

                FileDialog {
                    id: fileDialog

                    folder : videoUrl
                    title: qsTr("Open")
                    nameFilters: [qsTr("MP4 files (*.mp4)"), qsTr("All files (*.*)")]
                    onAccepted: mediaplayer.source = fileDialog.fileUrl
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: "#9c27b0"
                    border.color: control.down ? "#9c27b0" : "#9c27b0"
                    border.width: 1
                    radius: 5
                }

            }


            //отвечает за кнопку сфотографировать
            Label{
                          id:positionLabel
                          readonly property int minutes: Math.floor(mediaplayer.position / 60000)
                          readonly property int seconds: Math.round((mediaplayer.position % 60000) / 1000)
                          text: Qt.formatTime(new Date(0, 0, 0, 0, minutes, seconds), qsTr("mm:ss"))
                      }
        }


    }

}





