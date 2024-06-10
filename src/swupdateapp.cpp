// SPDX-License-Identifier: MIT
/*
 * Copyright (C) 2022 He Yong <hyyoxhk@163.com>
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>
#include <QLocale>
#include <QTranslator>
#include <QSocketNotifier>

#include <unistd.h>
#include <progress_ipc.h>

#include "swupdateapp.h"
#include "swupdateui.h"

#include <QDebug>

static QGuiApplication *createApp(int &argc, char **argv)
{
    QGuiApplication *app = new QGuiApplication(argc, argv);

    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "smartHmi_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app->installTranslator(&translator);
            break;
        }
    }

    return app;
}



SWUpdateApp::SWUpdateApp(int &argc, char **argv)
    : m_app(createApp(argc, argv))
{
//    m_config = new Config(this)

    m_engine = new QQmlApplicationEngine(this);
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(m_engine, &QQmlApplicationEngine::objectCreated,
                     m_app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QScreen *screen = m_app->primaryScreen();
    m_engine->rootContext()->setContextProperty("swidth", int(screen->geometry().width()));
    m_engine->rootContext()->setContextProperty("sheight", int(screen->geometry().height()));

    qDebug() << "The width is:" << screen->geometry().width();
    qDebug() << "The width is:" << screen->geometry().height();

    registerQmlTypes();
    setupQmlContextProperties();
    m_engine->load(url);

    m_ipcFd = progress_ipc_connect(true);
    QSocketNotifier *ipcConnect = new QSocketNotifier(m_ipcFd, QSocketNotifier::Read, this);

    connect(ipcConnect, &QSocketNotifier::activated, this, &SWUpdateApp::onActivated);

}

SWUpdateApp::~SWUpdateApp()
{
//    if (m_ui != nullptr)
//        delete m_ui;
//    close(m_ipcFd);
}

void SWUpdateApp::onActivated(void)
{
    struct progress_msg msg;
    bool wait_update = true;

    if (progress_ipc_receive(&m_ipcFd, &msg) <= 0)
        return;

    if (wait_update) {
        if (msg.status == START || msg.status == RUN) {
            qDebug() << "SWUpdateUI";
            wait_update = false;
        }
    }

//    if (!wait_update) {

//    }

//    if (msg.status == FAILURE || msg.status == FAILURE)
//        delete m_ui;
}

int SWUpdateApp::exec()
{
    return m_app->exec();
}

void SWUpdateApp::registerQmlTypes()
{
    //qmlRegisterType<WifiIcon>("com.xxx.hmi", 1, 0, "WifiIcon");
}

void SWUpdateApp::setupQmlContextProperties()
{
//    auto beep = new Beep(this);
//    m_engine->rootContext()->setContextProperty("beep", beep);
}
