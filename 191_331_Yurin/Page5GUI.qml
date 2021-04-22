import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.4
import QtWinExtras 1.0
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12
import QtWebView 1.1


Page {
    id: page5GUI

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

    ColumnLayout{
            anchors.topMargin: 77
            anchors.fill: parent

            WebView{
                Layout.row: 3
                id: webView

                 url:"https://connect.ok.ru/oauth/authorize?client_id=512000563471&scope=VALUABLE_ACCESS;LONG_ACCESS_TOKEN&response_type=token&redirect_uri=https://apiok.ru/oauth_callback"
                Layout.fillWidth: true
                Layout.fillHeight: true
                onLoadingChanged: {
                    final_ac.text = webView.url
                    console.info("*** "+ webView.url)

                    success(webView.url)
                    failed(webView.url)
                    hashvd(webView.url)
                    cancel(webView.url)

                    var token = httpController.success(webView.url)
                    var error = httpController.failed(webView.url)
                    var annul = httpController.cancel(webView.url)

                    if(token !== " "){

                        tokens.text = token
                        tokens.visible = token === " " ? false : true;
                        mailButton.visible = token === " " ? false : true;
                        webView.visible = token === " " ? true : false;
                        successtoken.visible = token === " " ? false : true;
                    }
                    else if (error === true){

                        webView.visible = error === false ? true : false;
                        failedlogin.visible = error === false ? false : true;
                        buttonreturn.visible = error === false ? false : true;
                    }
                    else
                    {
                        webView.visible = annul === false ? true : false;
                        labelreturn.visible = annul === false ? false : true;
                        buttonreturn.visible = annul === false ? false : true;


                    }

                }
            }
            Label{

                visible: false

                font.pixelSize: 9
                Layout.alignment: Qt.AlignCenter

                id:tokens
            }

            Label{
                text: "Вы вошли в систему"
                visible: false
                Layout.alignment: Qt.AlignCenter

                id:successtoken
                font.pixelSize: 25
                font.italic: true
                color: "#ffab25"
            }

            Button{
                visible: false
                id:mailButton
                font.pixelSize: 13
                text: "Показать фото"
                Layout.row:3
                Layout.alignment: Qt.AlignCenter
                onClicked:{
                    //                     success(final_ac.text);
                    //webView.goBack();
                           restRequest();
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 20
                    opacity: enabled ? 1 : 0.3
                    color: "#ffab25"
                    radius: 10
                }

            }
//            Label{
//                visible: false
//                Layout.row: 1

//                id:successtoken
//                font.pixelSize: 25
//                font.italic: true
//                color: "#ffab25"
//                text: "Вы вошли в систему"

//            }
            Button{
                visible: false
                id:buttonreturn
                text: "Повторить попытку"
                Layout.row:3
                Layout.alignment: Qt.AlignCenter
                onClicked:{
                    webView.url = "https://connect.ok.ru/oauth/authorize?client_id=512000563471&scope=VALUABLE_ACCESS;LONG_ACCESS_TOKEN&response_type=token&redirect_uri=https://apiok.ru/oauth_callback"
                  buttonreturn.visible = false
                    webView.visible = true
                    labelreturn.visible = false
                    failedlogin.visible = false
                }


            }
            Label{
                visible: false
                Layout.row: 4
                Layout.alignment: Qt.AlignCenter
                id:labelreturn
                 font.pixelSize: 30
                text: "Вы отменили попытку"
            }
            Label{
                visible: false
                Layout.row: 4
                Layout.alignment: Qt.AlignCenter
                id:failedlogin
                font.pixelSize: 30
                text: "Ошибка"
            }



            Label{
                Layout.row: 1
                id: final_ac
                Layout.alignment: Qt.AlignCenter
                visible: true
                Layout.fillWidth: true
            }

        }

}
