#include "upgradewindows.h"
#include <unistd.h>
#include <QSocketNotifier>
#include "swupdate/inc/progress_ipc.h"
#include <QDebug>

UpgradeWindows::UpgradeWindows(QGuiApplication *myapp,QQmlApplicationEngine *myengine)
{
    #ifndef UBUNTU_DEBUG
    m_ipcFd = progress_ipc_connect(true);
    QSocketNotifier *ipcConnect = new QSocketNotifier(m_ipcFd, QSocketNotifier::Read, this);
    qDebug("m_ipcFd:%d\n", m_ipcFd);
    connect(ipcConnect, &QSocketNotifier::activated, this, &UpgradeWindows::onActivated);
    qDebug("UpgradeWindows connect success\n");
    #endif

}

QMutex UpgradeWindows::mutex;

UpgradeWindows *UpgradeWindows::instance = nullptr;
bool UpgradeWindows::swupdateStart = false;
UpgradeWindows *UpgradeWindows::getInstance(QGuiApplication *myapp, QQmlApplicationEngine *myengine)
{
    mutex.lock();
    if(instance==nullptr)
    {
        instance = new UpgradeWindows(myapp,myengine);
    }
    mutex.unlock();
    return instance;
}
void UpgradeWindows::onActivated()
{
    struct progress_msg msg;
    static int prog_p = 0;
    QString str;
    #ifndef UBUNTU_DEBUG
    if (progress_ipc_receive(&m_ipcFd, &msg) <= 0){
        return;
    }else {
        qDebug("onActivated, cur_image:%s, ",msg.cur_image);

        qDebug("source:%d, cur_step:%d status: %d cur_percent:%d, ",msg.source, msg.cur_step, msg.status, msg.cur_percent);
        qDebug("dwl_percent:%d, dwl_bytes:%lld\n",msg.dwl_percent, msg.dwl_bytes);
        switch (msg.cur_step) {
        case 1:
            emit this->qmlVisibleChanged(true);
            str = QString("image: %1").arg(msg.cur_image);
            qDebug() << str;
            emit this->qmlImageNameChanged(str);
            str = QString("setup %1 of %2: Download firmware...").arg(msg.cur_step).arg(msg.nsteps);
            qDebug() << str;
            emit this->qmlSwupdateProgChanged(str, msg.cur_percent);
            break;
        case 2:
            emit this->qmlVisibleChanged(true);
            str = QString("setup %1 of %2: Upgrade firmware...").arg(msg.cur_step).arg(msg.nsteps);
            qDebug() << str;
            emit this->qmlSwupdateProgChanged(str, msg.cur_percent);
            break;
        case 3:
            emit this->qmlVisibleChanged(true);
            str = QString("setup %1 of %2: Success").arg(msg.cur_step).arg(msg.nsteps);
            qDebug() << str;
            emit this->qmlSwupdateProgChanged(str, msg.cur_percent);
            break;
        }
    }
    prog_p++;

    if (msg.status == FAILURE || msg.status == FAILURE)
        this->swupdateStart = false;
    #endif
}

