#ifndef UTILS_H
#define UTILS_H

#include "Property.hpp"
#include <QColor>
#include <QGuiApplication>
#include <QObject>
#include <QtCore/QJniObject>
#include <QDir>
#include <QFile>
#include <QQmlEngine>
#include <QStringList>
#include <QVariant>
#include <QString>
class Utils : public QObject
{
    Q_OBJECT
public:
   explicit Utils(QObject *parent = nullptr,QQmlEngine *engine=nullptr);
   Q_INVOKABLE bool writeFile(const QString & path , const QVariant &data, bool compress);

	static void init();
private:
    QQmlEngine *_engine;
    QStringList _defaultImportPaths;
signals:
};

#endif // UTILS_H
