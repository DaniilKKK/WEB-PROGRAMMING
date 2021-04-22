#include <QDebug>
#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonDocument>
#include <QEventLoop>
#include <QJsonObject>
#include <QJsonArray>
#include <QtWidgets/QTableView>
#include <QCryptographicHash>
#include "Httpcontroller.h"
#include <model.h>


Httpcontroller::Httpcontroller(QObject *QMLObject) : pocaz(QMLObject)
{
    nam = new QNetworkAccessManager(this); // создаем менеджер
        //  connect(nam, &QNetworkAccessManager::finished, this, &HttpController::SlotFinished);
        connect(nam, &QNetworkAccessManager::finished, this, &Httpcontroller::onNetworkValue);
        app_model = new Model();
}

void Httpcontroller::getNetworkValue()
{ // запрос к сайту

    QNetworkRequest request;
    request.setUrl(QUrl("https://www.fclm.ru/ru/history"));
    qDebug() << request.url();
    QNetworkReply * reply;
    QEventLoop evntLoop;
    connect(nam, &QNetworkAccessManager::finished, &evntLoop, &QEventLoop::quit);
    reply = nam->get(request);
    evntLoop.exec();
    QString replyString = reply->readAll();
    // emit signalSendToQML(QString(replyString));

}
void Httpcontroller::onNetworkValue(QNetworkReply *reply)
{ // парсинг сайта

     QString str = reply->readAll(); // записывем в str наш сайт
     QObject* textField = pocaz->findChild<QObject*>("textField"); // ищем элемент textField, куда буем записывать
    // QObject* textFieldDate = pocaz->findChild<QObject*>("textFieldDate");
     QObject* textArea = pocaz->findChild<QObject*>("textArea"); // ищем элемент textArea, откуда будем брать

     textArea->setProperty("text", str); // задаем параметр "текст" для textArea из qml

     int j = 0;

      if((j = str.indexOf("temp fact__temp fact__temp_size_s", j)) != -1) // ищем индекс этого тега в тексте
      {
         textField->setProperty("text", str.mid( j + 162,2)); // мы находим 140 символ после тега и отсчитываем 2 символов и их выводим (курс доллара) и записываем в textField
         //textFieldDate->setProperty("text", str.mid( j + 115,3)); // мы находим 115 символ после тега и отсчитываем 3 символов и их выводим (дату) и записываем в textFieldDate
      }
}


bool Httpcontroller::failed (QString add){

    qDebug() <<  "failed";
    if(add.indexOf("st._hi=") != -1)
    {
        QString pop;
        pop = add.split("st._hi=")[1].split(" ")[0];
          return 1;
    }
    else {
          return 0;
    }
     return 0;
}

bool Httpcontroller::cancel (QString add){
qDebug() <<  "failedcancel";
    if(add.indexOf("error=") != -1)
    {
      QString pop;
        pop = add.split("error=")[1].split(" ")[0];

       return 1;
    }
    else {
        return 0;
    }
   return 0;
}

void Httpcontroller::hashvd(QString add){
    qDebug() <<  "failed_hashvd";
    if (add.indexOf("session_secret_key=") != -1) // условие если он найден то записать в переменну
      {
           secret = add.split("session_secret_key=")[1].split("&")[0]; //запись в переменную токена
           qDebug() << "Наш сикрет: " << secret;
           QString param = "application_key=CQAKJNJGDIHBABABAcount=10format=jsonmethod=photos.getPhotos"+secret;
              qDebug() << "Наш параметр" << param;
           QByteArray array;
           array.append(param);
           qDebug() << "Наш массив" << array;
           hash = QString(QCryptographicHash::hash((array),QCryptographicHash::Md5).toHex());
           qDebug() << "Наш хеш" << hash;
      }
      else{
          qDebug() << "Ошибка";


      }
}



QString Httpcontroller::success (QString add){ //функция для вывода access_token

    qDebug() <<"Р•СЃР»Рё РєРѕРЅРЅРµРєС‚ РїСЂРѕРёР·РѕС€РµР», РІС‹РІРѕРґ:"<< add;
    if (add.indexOf("access_token=") != -1) //условие если он найден то записать в переменну
    {
        m_accessToken = add.split("access_token=")[1].split("&")[0]; //запись в переменную токена
        qDebug() << "Наш токен: " << m_accessToken;
        return m_accessToken;
    }
    else{
        qDebug() << "Ошибка";
    }
    QString str = " ";
    return str;
}

void Httpcontroller::restRequest(){
    //qDebug() <<  "restre";
    QEventLoop loop;
    nam = new QNetworkAccessManager();

    QObject::connect(nam, //связываем loop  с нашим менеджером
                     SIGNAL(finished(QNetworkReply*)),
                     &loop,
                     SLOT(quit()));
    QNetworkReply *reply = nam->get(QNetworkRequest(QUrl( "https://api.ok.ru/fb.do?application_key=CLNMAQJGDIHBABABA&format=json&method=photos.getPhotos"
                                                          "&sig="+ hash +
                                                          "&access_token="+ m_accessToken  )));
    loop.exec();

    //    // вся строка JSON с сервера грузится в QJsonDocument
          QJsonDocument document = QJsonDocument::fromJson(reply->readAll());
       qDebug() << reply;
        qDebug() <<"Наш document"<< document;
          QJsonObject root = document.object();
          qDebug() <<"Наш root"<< root;
          QJsonValue itog = root.value("photos");
          qDebug() <<"Photos"<< itog;
    //     QJsonObject itog1 = itog.toObject();
    //    //qDebug() << itog1;
    //      QJsonValue itog2 = itog1.value("items");
    //    //qDebug() << itog2;
          QJsonArray smth = itog.toArray();
       //  qDebug()<<"хз что тут будет" << smth;
    //   // Перебираем все элементы массива
           for(int i = 0; i < smth.count(); i++){

            QJsonObject znach = smth.at(i).toObject();
    //       // Забираем значения свойств названия
             QString name = znach.value("user_id").toString();
             qDebug() << name;

    //       // Забираем значения свойств короткого названия
             QString shortname = znach.value("text").toString();
            qDebug() << shortname;

    //       // Забираем значения id
             int appid = znach.value("comments_count").toInt();
             qDebug() << appid;

    //       // Забираем ссылку на главную картинку
             QUrl pic = znach.value("pic50x50").toString();
             qDebug() << pic;

          app_model->addItem(ModelObject (name, shortname, pic, appid ));
           qDebug()<<"yfi ger" << app_model->Modelshortname;
            qDebug() << app_model->Modelname;
           qDebug() << app_model->Modelpic;
           qDebug() << app_model->Modelappid;

       }
    }
