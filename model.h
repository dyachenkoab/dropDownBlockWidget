#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QStandardItemModel>

class Model : public QStandardItemModel
{
    Q_OBJECT
    enum Roles { ElapsedTimeRole = Qt::UserRole + 1, CurrentTimeRole };
    QVariant data( const QModelIndex &index, int role = Qt::DisplayRole ) const;


public:
    explicit Model(QObject *parent = nullptr);
    ~Model() = default;
    QHash<int, QByteArray> roleNames() const;

signals:

};

#endif // MODEL_H
