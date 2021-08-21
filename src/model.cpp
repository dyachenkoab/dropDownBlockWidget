#include "model.h"

Model::Model( QObject *parent ) : QAbstractListModel( parent )
{
    m_timer = new QTimer();
    connect( m_timer, &QTimer::timeout, this, &Model::tic_tac );
    m_timer->start( 1000 );
}

void Model::addData()
{
    BigData data;
    beginInsertRows( QModelIndex(), rowCount(), rowCount() );
    mData.insert( rowCount(), data );
    endInsertRows();
}

bool Model::changeStar( const int &index )
{
    return mData[index].m_amIStar = !mData[index].m_amIStar;
}

bool Model::getAmIStar( const int &index )
{
    return mData[index].m_amIStar;
}

void Model::removeStarredData()
{
    for ( int i = mData.count() - 1; i >= 0; i-- ) {
        if ( mData[i].m_amIStar ) {
            removeRow( i );
        }
    }
}

void Model::tic_tac()
{
    int i = 0;
    for ( auto &x : mData ) {
        x.m_elapsedTime = QTime::fromString( "00:00:00" ).addMSecs( x.m_timeFromCreation.elapsed() );
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
    QHash<int, QByteArray> roles;
    roles[ElapsedTimeRole] = "elapsedTime";
    roles[CurrentTimeRole] = "currentTime";
    return roles;
}

int Model::rowCount( const QModelIndex &parent ) const
{
    Q_UNUSED(parent)
    return mData.count();
}

bool Model::removeRows( int row, int count, const QModelIndex &parent )
{
    beginRemoveRows( parent, row, row + count - 1 );
    mData.removeAt( row );
    endRemoveRows();
    return true;
}
