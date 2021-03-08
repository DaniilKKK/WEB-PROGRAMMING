#include <QGuiApplication>
#include <QQmlApplicationEngine>



int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));//сылка на ресурсы. Файл ресурсов, туда помещаются любые некопилируемые данные, изображения 3D сетки, аудио и тд
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
//конфигурайия релиз только под приложения и ничего большего
//конфигурация дебаг больше по объему, чем релиз так как содержит встроенную информацию для привзяки полученного машинного кода к исходным строчкам кода
//сборка дебаг больше и медленне в 3 раза и более, а также содержит инфу об исходном коде приложения по которому злоумышленники могут восстановить исхдный бит приложения
//1 отлдака QML кода и совместная откладка
/*отладка C++ производится обязательно в конфигурации и запущенным отладкчиком F5*/
/*кроме того отладка C++ может производиться печатью qDEbug*/

//2 раскладка по layouts и Anchors
//если на странице граф элементов немного, то можно выравникавать каждый элемент по границе соседнего
// button.bottom: label.top
//
