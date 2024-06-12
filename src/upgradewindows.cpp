#include "upgradewindows.h"
#include <unistd.h>
#include <QSocketNotifier>
#include "swupdate/inc/progress_ipc.h"

UpgradeWindows::UpgradeWindows(QApplication *myapp,QQmlApplicationEngine *myengine)
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
UpgradeWindows *UpgradeWindows::getInstance(QApplication *myapp, QQmlApplicationEngine *myengine)
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
            str.sprintf("setup %d of %d: Download firmware...", msg.cur_step, msg.nsteps);
            qDebug() << str;
            emit this->qmlSwupdateProgChanged(str, msg.cur_percent);
            break;
        case 2:
            emit this->qmlVisibleChanged(true);
            str.sprintf("setup %d of %d: Upgrade firmware...", msg.cur_step, msg.nsteps);
            qDebug() << str;
            emit this->qmlSwupdateProgChanged(str, msg.cur_percent);
            break;
        case 3:
            emit this->qmlVisibleChanged(true);
            str.sprintf("setup %d of %d: Success", msg.cur_step, msg.nsteps);
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

//void UpgradeWindows::onActivated()
//{
//    struct progress_msg msg;
//    static int prog_p = 0;
//    if (progress_ipc_receive(&m_ipcFd, &msg) <= 0){
//        return;
//    }else {
//        qDebug("onActivated:%d\n", msg.status);
//        if()
//        if (msg.status == START || msg.status == RUN) {
//            emit this->qmlVisibleChanged(true);
//            emit this->qmlSwupdateProgChanged(msg.status, "setup1: OTA升级开始", prog_p);
//        } else if(msg.status == DOWNLOAD || msg.status == PROGRESS){
//            emit this->qmlVisibleChanged(true);
//            emit this->qmlSwupdateProgChanged(msg.status, "setup2: 正在下载固件...", prog_p);
//        } else if(msg.status == SUCCESS || msg.status == DONE){
//            emit this->qmlVisibleChanged(true);
//            emit this->qmlSwupdateProgChanged(msg.status, "setup2: 正在下载固件...", prog_p);
//        }
//    }
//    prog_p++;
//    emit this->qmlSwupdateProgChanged(msg.status, prog_p);



//    if (msg.status == FAILURE || msg.status == FAILURE)
//        this->swupdateStart = false;
//}
