#include "watcher.h"
#include "qcoreapplication.h"
#include "qqmlengine.h"
#include <QDebug>
#include <QJSEngine>
#include <Qaterial/Qaterial.hpp>
Watcher::Watcher(QQmlEngine *engine, QObject *parent) : QObject{parent}, _engine{engine}
{
    QFileSystemWatcher *watcher = new QFileSystemWatcher(this);
    watcher->addPath(QCoreApplication::applicationDirPath());
    watcher->addPath("E:/PRIMARY/01STUDIO/SpeedNote/");
    //    watcher->addPath("E:/PRIMARY/01STUDIO/SpeedNote/qml/SpeedNote/hot_main.qml");
    //    watcher->addPath("E:/PRIMARY/01STUDIO/SpeedNote/qml/SpeedNote/Pages/Home.qml");
    connect(watcher, &QFileSystemWatcher::directoryChanged, this, [=](QString path) {
        //qDebug() << "detected";
        this->clearCache();
        emit this->fileChange(path);
    });
}

void Watcher::clearCache()
{
    _engine->clearComponentCache();
}

void Watcher::registerSingleton()
{
    qmlRegisterSingletonType<Watcher>("Watcher",
                                      1,
                                      0,
                                      "Watcher",
                                      [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
                                          Q_UNUSED(scriptEngine);
                                          auto *instance = new Watcher(engine, engine);
                                          instance->_defaultImportPaths = engine->importPathList();
                                          return instance;
                                      });
}
