#include "utils.h"

Utils::Utils(QObject *parent,QQmlEngine *engine) : QObject{parent}, _engine{engine}
{

}

void Utils::init(){
        qmlRegisterSingletonType<Utils>("Utils", 1, 0, "Utils", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
                                          Q_UNUSED(scriptEngine);
                                          auto *instance = new Utils(engine, engine);
                                          instance->_defaultImportPaths = engine->importPathList();
                                          return instance;
                                      });
    }


bool Utils::writeFile(const QString & path , const QVariant &data, bool compress) {
    QString dir = path.left(path.lastIndexOf(QStringLiteral("/"))+1);
    QDir().mkpath(dir);

    QFile file(path);
    if(!file.open(QFile::WriteOnly))
        return false;

    QByteArray bytes;
    if(data == QVariant::ByteArray)
        bytes = data.toByteArray();
    else
    {
        QDataStream stream(&bytes, QIODevice::WriteOnly);
        stream << data;
    }

    if(compress)
        bytes = qCompress(bytes);

    file.write(bytes);
    file.close();
    return true;
}
