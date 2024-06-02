// SPDX-License-Identifier: MIT
/*
 * Copyright (C) 2022 He Yong <hyyoxhk@163.com>
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "swupdateui.h"

SWUpdateUI::SWUpdateUI(QGuiApplication *app)

{
    //m_config = new Config(this);

    m_engine = new QQmlApplicationEngine(this);
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    connect(m_engine, &QQmlApplicationEngine::objectCreated, app,
            [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    registerQmlTypes();
    setupQmlContextProperties();
    m_engine->load(url);
}

SWUpdateUI::~SWUpdateUI()
{
    if (m_engine != nullptr) {
        delete m_engine;
        m_engine = nullptr;
    }

//    if (m_app != nullptr) {
//        delete m_app;
//        m_app = nullptr;
//    }
}

//int SWUpdateUI::exec()
//{
//    return m_app->exec();
//}

void SWUpdateUI::registerQmlTypes()
{
    //qmlRegisterType<WifiIcon>("com.xxx.hmi", 1, 0, "WifiIcon");
}

void SWUpdateUI::setupQmlContextProperties()
{
//    auto beep = new Beep(this);
//    m_engine->rootContext()->setContextProperty("beep", beep);
}

