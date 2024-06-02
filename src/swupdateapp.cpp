// SPDX-License-Identifier: MIT
/*
 * Copyright (C) 2022 He Yong <hyyoxhk@163.com>
 */

#include <QGuiApplication>
#include <QLocale>
#include <QTranslator>
#include <QSocketNotifier>

#include <unistd.h>
#include <progress_ipc.h>

#include "swupdateapp.h"
#include "swupdateui.h"

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

    m_ipcFd = progress_ipc_connect(true);
    QSocketNotifier *ipcConnect = new QSocketNotifier(m_ipcFd, QSocketNotifier::Read, this);

    connect(ipcConnect, &QSocketNotifier::activated, this, &SWUpdateApp::onActivated);
}

SWUpdateApp::~SWUpdateApp()
{
    if (m_ui != nullptr)
        delete m_ui;
    close(m_ipcFd);
}

void SWUpdateApp::onActivated(void)
{
    struct progress_msg msg;

    if (progress_ipc_receive(&m_ipcFd, &msg) <= 0)

    if (msg.status == START || msg.status == RUN) {
        m_ui = new SWUpdateUI(m_app);
    }

    if (msg.status == FAILURE || msg.status == FAILURE)
        delete m_ui;
}

int SWUpdateApp::exec()
{
    return m_app->exec();
}
