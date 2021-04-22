/*#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QNetworkReply>
#include "webappcontroller.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);


   webappcontroller Webappcontroller;

    QQmlApplicationEngine engine;


    QQmlContext *context = engine.rootContext();
   context->setContextProperty(" webappcontroller", & Webappcontroller);
      //преобразование пути стартовой страницы из char в Qurl

      //подлючение слота, срабатывающего после создания objectCreated
   engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
   if (engine.rootObjects().isEmpty())
       return -1;


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);




QObject::connect(engine.rootObjects().first(), SIGNAL(failed(QString)),
&Webappcontroller, SLOT(failed(QString)));

QObject::connect(engine.rootObjects().first(), SIGNAL(cancel(QString)),
&Webappcontroller, SLOT(cancel(QString)));



QObject* main = engine.rootObjects()[0];
webappcontroller sendtoqml(main);
engine.rootContext()->setContextProperty("_send", &sendtoqml);

return app.exec();//запуск бесконечного цикла обработки сообщений и слотов/сигналов

}*/



#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QNetworkReply>
#include "Httpcontroller.h"
#include "model.h"



int main(int argc, char *argv[])
{
   //Вызов независимой функции
   //в составе класса QCoreApplication (без создания экземпляров класса)
   //просто настройка масштабирования экрана.
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //Создается базовое приложение с графической областью
QGuiApplication app(argc, argv);



        QCoreApplication::setOrganizationName(QStringLiteral("MobDev"));

      QCoreApplication::setOrganizationDomain(QStringLiteral("qt"));

         Httpcontroller httpcontroller;

     //Создание браузерного движка
    QQmlApplicationEngine engine;

     QQmlContext *context = engine.rootContext();

    context->setContextProperty("Httpcontoller", &httpcontroller);
       //преобразование пути стартовой страницы из char в Qurl


       //подлючение слота, срабатывающего после создания objectCreated
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;





    QObject::connect(engine.rootObjects().first(), SIGNAL(failed(QString)),
    &httpcontroller, SLOT(failed(QString)));



    QObject::connect(engine.rootObjects().first(), SIGNAL(cancel(QString)),
    &httpcontroller, SLOT(cancel(QString)));


    QObject::connect(engine.rootObjects().first(), SIGNAL(requestOkAPI()),
    &httpcontroller, SLOT(restRequest()));


    QObject::connect(engine.rootObjects().first(), SIGNAL(connectionDump(QString)),
    &httpcontroller, SLOT(success(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(hashvd(QString)),
       &httpcontroller, SLOT(hashvd(QString)));

    QObject* main = engine.rootObjects()[0];
    Httpcontroller sendtoqml(main);
    engine.rootContext()->setContextProperty("_send", &sendtoqml);

    return app.exec();//запуск бесконечного цикла обработки сообщений и слотов/сигналов
}
