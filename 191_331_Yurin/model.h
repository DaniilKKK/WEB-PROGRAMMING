#ifndef MODEL_H
#define MODEL_H
#include <QObject>
#include <QAbstractItemModel>
#include<QAbstractListModel>
#include <QList>
#include <QModelIndex>
#include <QVariant>
#include <QUrl>
#include <QVariant>

class ModelObject
{
public:
    ModelObject(const QString &pub_shortname,
                    const QString &pub_name,
                    const QUrl &pub_pic,
                    const int &pub_appid);
        //
        QString getshortname() const;
        QString getname() const;
        QUrl getpic() const;
        int getappid() const;
private:
    QString m_shortname;
    QString m_name;
    QUrl m_pic;
    int m_appid;
    // прочие свойства для хранения ID, URL фотографии и др.
};

class Model : public QAbstractListModel
{
    Q_OBJECT
public:
    enum enmRoles {
        Modelshortname = Qt::UserRole + 1,
         Modelname,
         Modelpic,
         Modelappid
    };
    Model(QObject *parent = nullptr);

    void addItem(const ModelObject & newItem);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const; // возвращает по индексу переменную (используется в ЛР 8)

    QVariantMap get(int idx) const;

    void clear();

 protected:
    QHash<int, QByteArray> roleNames() const;
    // ключ - значение
    // нужен, чтобы строковые имена приводить в соответствие к полям френда

 private:

   QList<ModelObject> m_items;

};

#endif // MODEL_H
