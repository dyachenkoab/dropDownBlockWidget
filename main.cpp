#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "model.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    Model m;
    m.addData(BigData("12", "123"));
    m.addData(BigData("14", "145"));
    m.addData(BigData("16", "167"));

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    engine.rootContext()->setContextProperty("myModel", &m);

    engine.load(url);


    return app.exec();
}
