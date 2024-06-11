#ifndef UPGRADEWINDOWS_H
#define UPGRADEWINDOWS_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QMutex>



class UpgradeWindows : public QObject
{

    Q_OBJECT
private:
    explicit UpgradeWindows(QApplication *myapp,QQmlApplicationEngine *myengine);
    static UpgradeWindows *instance;
public:
    enum SW_STAT {
        SW_CONFIRM,
        SW_CONFIRM_EXIT,
        SW_START,
        SW_SUCCESS,
        SW_END,
        SW_ABORD
    };
    static UpgradeWindows *getInstance(QApplication *myapp,QQmlApplicationEngine *myengine);
    static QMutex mutex;
    static QString swupdateStatus;
    static bool swupdateStart;
    static bool swupdateAbord;
    static bool swupdateEnd;
private:
    int m_ipcFd;

protected Q_SLOTS:
    void onActivated(void);
signals:
    void qmlVisibleChanged(bool visible);
    void qmlSwupdateProgChanged(QString str, int pProgress);

};

#endif // UPGRADEWINDOWS_H
