// SPDX-License-Identifier: MIT
/*
 * Copyright (C) 2022 He Yong <hyyoxhk@163.com>
 */

#ifndef SWUPDATEUI_H
#define SWUPDATEUI_H

#include <QObject>

class Config;
class QGuiApplication;
class QQmlApplicationEngine;

class SWUpdateUI : public QObject
{
    Q_OBJECT
public:
    explicit SWUpdateUI(QGuiApplication *app);
    ~SWUpdateUI();

//    int exec();

protected Q_SLOTS:

private:
    Config *m_config;
    QQmlApplicationEngine *m_engine;

    void registerQmlTypes();
    void setupQmlContextProperties();
};

#endif // SWUPDATEAPP_H
