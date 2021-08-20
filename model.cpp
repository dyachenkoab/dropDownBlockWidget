#include "model.h"
#include <QDebug>

Model::Model( QObject *parent ) : QAbstractListModel( parent )
{
}

void Model::addData(const BigData &data)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mData << data;
    endInsertRows();
}

QVariant Model::data( const QModelIndex &index, int role ) const
{
    if ( index.row() < 0 || index.row() >= mData.count() )
        return QVariant();

    const BigData &data = mData[index.row()];
    switch ( role ) {
        case CurrentTimeRole:
            return data.currT();
            break;
        case ElapsedTimeRole:
            return data.elapsT();
            break;
        default:
            return QVariant();
    }
}

QHash<int, QByteArray> Model::roleNames() const
{
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[CurrentTimeRole] = "currentTime";
    roles[ElapsedTimeRole] = "elapsedTime";
    return roles;
}

int Model::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return mData.count();
}
