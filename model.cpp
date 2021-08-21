#include "model.h"

Model::Model( QObject *parent ) : QAbstractListModel( parent )
{
    tm = new QTimer();
    connect( tm, &QTimer::timeout, this, &Model::tic_tac );
    tm->start( 1000 );
}

void Model::addData()
{
    BigData data;
    beginInsertRows( QModelIndex(), rowCount(), rowCount() );
    mData.insert( rowCount(), data );
    endInsertRows();
}

void Model::changeData( const int &_index )
{
    mData[_index].m_elapsedTime = QTime::currentTime();
    const QModelIndex idx = index( _index );
    emit dataChanged( idx, idx );
}

bool Model::changeStar( const int &_index )
{
    return mData[_index].m_amIStar = !mData[_index].m_amIStar;
}

bool Model::getAmIStar( const int &_index )
{
    return mData[_index].m_amIStar;
}

void Model::removeStarredData()
{
    for ( int i = mData.count() - 1; i >= 0; i-- ) {
        if ( mData[i].m_amIStar ) {
            removeRow( i );
        }
    }
}

bool Model::removeRows( int row, int count, const QModelIndex &parent )
{
    beginRemoveRows( parent, row, row + count - 1 );
    mData.removeAt( row );
    endRemoveRows();
    return true;
}

void Model::tic_tac()
{
    int i = 0;
    for ( auto &x : mData ) {
        x.m_elapsedTime = QTime::fromString( "00:00:00" ).addMSecs( x.timer.elapsed() );
        x.m_currentTime = QTime::currentTime();
        const QModelIndex idx = index( i++ );
        emit dataChanged( idx, idx );
    }
}

QVariant Model::data( const QModelIndex &index, int role ) const
{
    if ( index.row() < 0 || index.row() >= mData.count() )
        return QVariant();

    const BigData &data = mData[index.row()];
    switch ( role ) {
        case ElapsedTimeRole:
            return data.getElapsedTime();
            break;
        case CurrentTimeRole:
            return data.getCurrentTime();
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
    roles[ElapsedTimeRole] = "elapsedTime";
    roles[CurrentTimeRole] = "currentTime";
    return roles;
}

int Model::rowCount( const QModelIndex &parent ) const
{
    if ( parent.isValid() )
        return 0;
    return mData.count();
}
