#ifndef MODEL_H
#define MODEL_H

#include <QDebug>
#include <QElapsedTimer>
#include <QObject>
#include <QStandardItemModel>
#include <QTime>
#include <QTimer>

struct BigData {
    QElapsedTimer timer;
    QTime m_elapsedTime;
    QTime m_currentTime;
    bool m_amIStar;

    BigData( const bool _amIStar = false )
    {
        m_elapsedTime = QTime::fromString( "00:00:00" );
        m_amIStar = _amIStar;
        timer.start();
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
    QTimer *tm;

    enum Roles { CurrentTimeRole = Qt::UserRole + 1, ElapsedTimeRole };

public:
    explicit Model( QObject *parent = nullptr );
    ~Model()
    {
        delete tm;
    };
    QHash<int, QByteArray> roleNames() const override;
    QVariant data( const QModelIndex &index, int role = Qt::DisplayRole ) const override;
    int rowCount( const QModelIndex &parent = QModelIndex() ) const override;
    bool removeRows( int row, int count = 1, const QModelIndex &parent = QModelIndex() ) override;

signals:

public slots:
    void addData();
    void changeData( const int &_index );
    bool changeStar( const int &_index );
    bool getAmIStar( const int &_index );
    void tic_tac();
    void removeStarredData();
};

#endif // MODEL_H
