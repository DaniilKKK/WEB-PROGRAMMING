import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0



ApplicationWindow {
    width: 740
    height: 500
    visible: true
    title: qsTr("Программирование WEB-приложений")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1GUI {
            id: page1GUI
        }

        Page2GUI {
            id: page2GUI
        }

        Page3GUI {
            id: page3GUI
        }

        Page4GUI {
            id: page4GUI
        }
        Page5GUI {
            id: page5GUI
        }
    }


    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Page 1")
        }
        TabButton {
            text: qsTr("Page 2")
        }

        TabButton {
            text: qsTr("Page 3")
        }
        TabButton {
            text: qsTr("Page 4")
        }
        TabButton {
            text: qsTr("Page 5")
        }
    }
}
/* .pro-это файл настройки сситемы Qmake.
Все файлы из дерева проекта перечислены
и все файлы удаленные из проекта удаляются из дерева
Доп библиотеки подключается через pro файл
Разлчие процесса сборки для ОС задается в pro
В Main - точка входа в приложение. А в случает приложения QML в main создается объект движка- интерпретатора QML hfpvtnrb
Как и в любом C++ приложении в проекте могут быть другие cpp и h файлы
описание интерфейса приложения и простейших механик его логики содержится в файлах QML, которые выполняют роль фронтенда.

*/
