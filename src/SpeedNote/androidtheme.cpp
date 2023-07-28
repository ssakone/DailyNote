#include "androidtheme.h"

AndroidTheme::AndroidTheme(QObject *parent)
    : QObject{parent}
{
#if defined(Q_OS_ANDROID)
    connect(this, &AndroidTheme::statusColorChanged, [=](QColor statusBarColor) {
        QNativeInterface::QAndroidApplication::runOnAndroidMainThread([=]() {
            QJniObject w = QNativeInterface::QAndroidApplication::context(); // ->callObjectMethod();

            QJniObject window = w.callObjectMethod("getWindow", "()Landroid/view/Window;");
            window.callMethod<void>("addFlags", "(I)V", 0x80000000);
            window.callMethod<void>("clearFlags", "(I)V", 0x04000000);
            window.callMethod<void>("setStatusBarColor",
                                    "(I)V",
                                    statusBarColor.rgba()); // Desired statusbar color
        });
    });

    connect(this, &AndroidTheme::navigationColorChanged, [=](QColor navigationColor) {
        QNativeInterface::QAndroidApplication::runOnAndroidMainThread([=]() {
            QJniObject w = QNativeInterface::QAndroidApplication::context(); // ->callObjectMethod();

            QJniObject window = w.callObjectMethod("getWindow", "()Landroid/view/Window;");
            window.callMethod<void>("addFlags", "(I)V", 0x80000000);
            window.callMethod<void>("clearFlags", "(I)V", 0x04000000);
            window.callMethod<void>("setNavigationBarColor", "(I)V", navigationColor.rgba());
        });
    });

    connect(this, &AndroidTheme::themeChanged, [=](int theme) {
        QNativeInterface::QAndroidApplication::runOnAndroidMainThread([=]() {
            QJniObject w = QNativeInterface::QAndroidApplication::context(); // ->callObjectMethod();

            QJniObject window = w.callObjectMethod("getWindow", "()Landroid/view/Window;");
            window.callMethod<void>("addFlags", "(I)V", 0x80000000);
            window.callMethod<void>("clearFlags", "(I)V", 0x04000000);
            QJniObject decorView = window.callObjectMethod("getDecorView", "()Landroid/view/View;");
            decorView.callMethod<void>("setSystemUiVisibility",
                                       "(I)V",
                                       theme == 1 ? 0x04000000 : 0x00002000);
        });
    });
#endif
}
