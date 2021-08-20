#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QStandardItemModel>

struct BigData {
    QString currentTime;
    QString elapsedTime;
    bool amIStar;

    BigData( const QString &_currentTime, const QString &_elapsedTime, const bool _amIStar = false )
    {
        currentTime = _currentTime;
        elapsedTime = _elapsedTime;
        amIStar = _amIStar;
    }
    ~BigData() = default;
    QString currT() const
    {
        return currentTime;
    }
    QString elapsT() const
    {
        return elapsedTime;
    }
};

class Model : public QAbstractListModel
{
    Q_OBJECT

    QList<BigData> mData;

    enum Roles { ElapsedTimeRole = Qt::UserRole + 1, CurrentTimeRole };

public:
    explicit Model( QObject *parent = nullptr );
    ~Model() = default;
    QHash<int, QByteArray> roleNames() const;
    QVariant data( const QModelIndex &index, int role = Qt::DisplayRole ) const;
    int rowCount( const QModelIndex &parent = QModelIndex()  ) const;

    void addData(const BigData &data);
    void star();

signals:
};

#endif // MODEL_H
