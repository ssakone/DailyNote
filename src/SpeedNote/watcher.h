#ifndef WATCHER_H
#define WATCHER_H

#include "qqmlengine.h"
#include <QFileSystemWatcher>
#include <QObject>
class Watcher : public QObject
{
    Q_OBJECT
public:
    explicit Watcher(QQmlEngine *engine, QObject *parent = nullptr);
    Q_INVOKABLE void clearCache();
    static void registerSingleton();

private:
    QQmlEngine *_engine;
    QStringList _defaultImportPaths;
signals:
    void fileChange(QString path);
};

#endif // WATCHER_H
