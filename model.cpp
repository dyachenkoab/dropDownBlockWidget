#include "model.h"

Model::Model( QObject *parent ) : QStandardItemModel( parent )
{
    for ( int row = 0; row < 5; ++row ) {
        QStandardItem *item = new QStandardItem( QString( "row %0" ).arg( row ) );
        this->insertRow( row, item );
    }
}

QVariant Model::data( const QModelIndex &index, int role ) const
{

    // Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index( index.row(), columnId );

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */
    return QStandardItemModel::data( modelIndex, Qt::DisplayRole );
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
