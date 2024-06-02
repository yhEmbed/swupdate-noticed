// SPDX-License-Identifier: MIT
/*
 * Copyright (C) 2022 He Yong <hyyoxhk@163.com>
 */

#ifndef SWUPDATEAPP_H
#define SWUPDATEAPP_H

#include <QObject>

class Config;
class QGuiApplication;
class SWUpdateUI;

class SWUpdateApp : public QObject
{
    Q_OBJECT
public:
    explicit SWUpdateApp(int &argc, char **argv);
    ~SWUpdateApp();

    int exec();

protected Q_SLOTS:
    void onActivated(void);

private:
    Config *m_config;
    QGuiApplication *m_app;
    SWUpdateUI *m_ui;

    int m_ipcFd;

};

#endif // SWUPDATEAPP_H
