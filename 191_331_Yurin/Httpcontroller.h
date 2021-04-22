#ifndef HTTPCONTROLLER_H
#define HTTPCONTROLLER_H


#include <QObject>
#include <QNetworkAccessManager>
#include <QCryptographicHash>
#include <model.h>


class Httpcontroller : public QObject
{
    Q_OBJECT
public:
    explicit Httpcontroller  (QObject *parent = nullptr);
     QNetworkAccessManager *nam;

     QString m_accessToken; // полученный access_token
    Model *app_model; // наша модель
     QString secret; //получение секрета
     QString hash; // получение хеша

signals:
public slots:
    void onNetworkValue(QNetworkReply *reply);
    void getNetworkValue();
    QString success (QString add);
            bool failed (QString add);
            bool cancel (QString add);
            void restRequest();
            void hashvd(QString add);

protected:
    QObject *pocaz;

};


#endif // HTTPCONTROLLER_H
