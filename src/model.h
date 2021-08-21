#ifndef MODEL_H
#define MODEL_H

#include <QDebug>
#include <QElapsedTimer>
#include <QObject>
#include <QStandardItemModel>
#include <QTime>
#include <QTimer>

struct BigData {
    QElapsedTimer m_timeFromCreation;
    QTime m_elapsedTime;
    QTime m_currentTime;
    bool m_amIStar;

    explicit BigData( const bool _amIStar = false )
    {
        m_elapsedTime = QTime::fromString( "00:00:00" );
        m_currentTime = QTime::currentTime();
        m_amIStar = _amIStar;
        m_timeFromCreation.start();
    }
    ~BigData() = default;
    QString getElapsedTime() const
    {
        return m_elapsedTime.toString();
    }
    QString getCurrentTime() const
    {
        return m_currentTime.toString();
    }
};

class Model : public QAbstractListModel
{
    Q_OBJECT

    QList<BigData> mData;
    QTimer *m_timer;

    enum Roles { CurrentTimeRole = Qt::UserRole + 1, ElapsedTimeRole };
    void tic_tac();

protected:
    QHash<int, QByteArray> roleNames() const override;
    QVariant data( const QModelIndex &index, int role = Qt::DisplayRole ) const override;
    int rowCount( const QModelIndex &parent = QModelIndex() ) const override;
    bool removeRows( int row, int count = 1, const QModelIndex &parent = QModelIndex() ) override;


public:
    explicit Model( QObject *parent = nullptr );
    ~Model() { delete m_timer; }

public slots:
    void addData();
    bool changeStar( const int &index );
    bool getAmIStar( const int &index );
    void removeStarredData();
};

#endif // MODEL_H
