#ifndef ANDROIDTHEME_H
#define ANDROIDTHEME_H

#include "Property.hpp"
#include <QColor>
#include <QGuiApplication>
#include <QObject>
#include <QJniObject>
class AndroidTheme : public QObject
{
    Q_OBJECT
    QMACROS_PROPERTY(QColor, statusColor, StatusColor)
    QMACROS_PROPERTY(QColor, navigationColor, NavigationColor)
    QMACROS_PROPERTY(int, theme, Theme)
public:
    explicit AndroidTheme(QObject *parent = nullptr);

signals:
};

#endif // ANDROIDTHEME_H
