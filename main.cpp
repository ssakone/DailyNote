#include "src/SpeedNote/androidtheme.h"
#include "src/SpeedNote/watcher.h"
#include "src/SpeedNote/utils.h"
#include <QFont>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <Qaterial/Qaterial.hpp>
#if defined(Q_OS_WINDOWS)
//#define HOT_RELOAD
#endif
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationName("01Studio");
    app.setOrganizationDomain("01Studio.io");
    app.setApplicationName("Business Mobile");
    QFont fon("Roboto");
    app.setFont(fon);
    QQmlApplicationEngine engine;

    Q_INIT_RESOURCE(SpeedNote);

    engine.addImportPath("qrc:///");

#if defined(HOT_RELOAD)
    QString hot_reload_server_ip("localhost");
    //QString hot_reload_server_ip("10.0.2.2");
    //QString hot_reload_server_ip("192.168.1.18");
    engine.addImportPath("http://" + hot_reload_server_ip + ":8000/qml/");
#elif defined(Q_OS_WINDOWS)
    engine.addImportPath("E:/PRIMARY/01STUDIO/SpeedNote/qml/");
#elif defined(Q_OS_ANDROID)
    engine.addImportPath("qrc:/qml/");
#elif defined(Q_OS_LINUX)
    engine.addImportPath("/home/enokas/Workstation/01STUDIO/SpeedNote/qml/");
#endif
    qaterial::loadQmlResources();
    qaterial::registerQmlTypes();
    Watcher::registerSingleton();
    Utils::init();
    qmlRegisterType<AndroidTheme>("SpeedNote.AndroidTheme", 1, 0, "AndroidTheme");
#if defined(HOT_RELOAD)
    const QUrl url("qrc:/qml/SpeedNote/main.qml");
    engine.rootContext()->setContextProperty("devMode", true);
#elif defined(Q_OS_WINDOWS)
    const QUrl url("file:///E:/PRIMARY/01STUDIO/SpeedNote/qml/SpeedNote/main.qml");
#elif defined(Q_OS_ANDROID)
    const QUrl url("qrc:/qml/SpeedNote/main.qml");
#elif defined(Q_OS_LINUX)
    const QUrl url("file:////home/enokas/Workstation/01STUDIO/SpeedNote/qml/SpeedNote/main.qml");
#endif

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);
#if defined(HOT_RELOAD)
    engine.rootContext()->setContextProperty("devMode", true);
    engine.rootContext()->setContextProperty("hot_reload_server_ip", hot_reload_server_ip);
#else
    engine.rootContext()->setContextProperty("devMode", QVariant(false));
#endif

    return app.exec();
}
