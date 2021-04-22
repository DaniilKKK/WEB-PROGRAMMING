#include "model.h"
#include <QAbstractItemModel>
#include <QMap>


// TODO реализация конструктора и get-методов FriendObject простейшая, проработать самостоятельно

ModelObject::ModelObject(const QString &getshortname, const QString &getname, const QUrl &getpic, const int &getappid)
    :   m_shortname(getshortname),
        m_name(getname),
        m_pic(getpic),
        m_appid(getappid)
{
 //
}


Model::Model(QObject *parent) : QAbstractListModel(parent)
{
    //пусто
}


QString ModelObject::getshortname() const{ // функция для получения имени друга
    return m_shortname;
}

QString ModelObject::getname() const{ // функция для получения фамилии друга
    return m_name;
}

QUrl ModelObject::getpic() const{ // функция для получения фото друга
    return m_pic;
}

int ModelObject::getappid() const{ // функция для получения id друга
    return m_appid;
}

void Model::addItem(const ModelObject & newItem){
    // не изменяется
  // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << newItem;
    endInsertRows();
}

int Model::rowCount(const QModelIndex &parent) const
{
    // не изменяется
   // метод используется ListView в QML для определения числа элементов
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant Model::data(const QModelIndex & index,
                                int role) const
{
     // метод используется в QML для получения значения одного поля под обозначением role одного элемента модели index
    if (index.row() < 0 || (index.row() >= m_items.count()))
        return QVariant();

    // TODO дописать выгрузку своих полей под своими обозначениями

    const ModelObject&itemToReturn = m_items[index.row()];
    if (role == Modelshortname)
    return itemToReturn.getshortname();
    else if (role == Modelname)
    return itemToReturn.getname();
    else if (role == Modelpic)
    return itemToReturn.getpic();
    else if (role == Modelappid)
    return itemToReturn.getappid();

    return QVariant();
}

QHash<int, QByteArray> Model::roleNames() const
{
    // метод используется в QML для сопоставления полей данных со строковыми названиями
     // TODO сопоставить полям данных строковые имена
    QHash<int, QByteArray> roles;

    roles[ Modelshortname] = "shortname";
    roles[ Modelname] = "name";
    roles[ Modelpic] = "pic50x50";
    roles[ Modelappid] = "appid";
    return roles;
}

QVariantMap Model::get(int idx) const
{
    // не изменяется
   // метод используется ListView в QML для получения значений полей idx-го элемента модели
    QVariantMap map;
    foreach(int k, roleNames().keys())
    {
        map[roleNames().value(k)] = data(index(idx, 0), k);
    }
    return map;
}

void Model::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);
    m_items.clear();
    endRemoveRows();
}
