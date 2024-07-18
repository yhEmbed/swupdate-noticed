#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QScreen>
#include <QtQml>                    // engine.rootContext()需要添加此头文件
#include "upgradewindows.h"

/*
1. app运行，创建透明ui。等待swupdate升级的信号。
2. 通过函数得到swupdate的信号。然后设置UpgradedWin为不透明。
3. 等待用户确定升级信息。（待添加此UI）
3. 通过函数更新swupdate升级进度。根据进度在UpgradedWin上面更新进度条和文本提示信息。
*/
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    // 默认屏幕大小 w:640  h:480
    int defaultWidth = 640;
    int defaultHeight = 480;
    QScreen *screen = QGuiApplication::primaryScreen ();
//    QRect screenRect =  screen->availableVirtualGeometry();
//    int screenWidth = screenRect.width(); // 设置全屏
//    int screenHeight = screenRect.height(); // 设置全屏
      int screenWidth = screen->geometry().width();
      int screenHeight = screen->geometry().height();
//    int screenWidth = 1280; // 640
//    int screenHeight = 768; // 480

    if (screenWidth < screenHeight){
        // Portrait orientation
        screenHeight = screenWidth / 1.77;  //1.77 is 16:9 aspect ratio
    }

    /// 线程安全的懒汉单例
    UpgradeWindows *upgradeWin = UpgradeWindows::getInstance(&app,&engine);
    upgradeWin->swupdateStart = false;
    engine.rootContext()->setContextProperty("gScreenWidth",screenWidth);
#ifdef UBUNTU_DEBUG
    engine.rootContext()->setContextProperty("gUbuntuDebug",1);
#else
    engine.rootContext()->setContextProperty("gUbuntuDebug",0);
#endif
//    engine.rootContext()->setContextProperty("gVisible",upgradeWin->swupdateStart);
    engine.rootContext()->setContextProperty("gScreenHeight",screenHeight);
    engine.rootContext()->setContextProperty("gUpgradeWin",upgradeWin);
    engine.rootContext()->setContextProperty("gRatioW",(float)screenWidth/(float)defaultWidth);
    engine.rootContext()->setContextProperty("gRatioH",(float)screenHeight/(float)defaultHeight);
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
