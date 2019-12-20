/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include <QGuiApplication>
#include <QQuickView>
#include <QtQml/QQmlEngine>

#include <QtGui/QMatrix4x4>
#include <QtGui/QOpenGLContext>
#include <QtGui/QFontDatabase>

#include <QtCore/QTextStream>

#include "graph.h"
#include <QtQml/QQmlContext>
#include <QtQml/QQmlProperty>

class WellBarHandler : public QObject
{
    Q_OBJECT

public:
    explicit WellBarHandler(QObject * parent_ = nullptr)
        : QObject(parent_)
    {
    }

public Q_SLOTS:
    void onDoubleClicked()
    {
        QTextStream stdOutStream(stdout);

        stdOutStream << "onDoubleClicked on C++-side!" << endl;
    }
};

int main(int argc, char *argv[])
{
//	QSurfaceFormat fmt;
//	fmt.setDepthBufferSize(24);

//	// OpenGL ES 3.0
//	qDebug("Requesting 3.0 context");
//	fmt.setVersion(3, 0);

//	QSurfaceFormat::setDefaultFormat(fmt);

    QGuiApplication a(argc, argv);

    qmlRegisterType<Graph>("Graph", 1, 0, "Graph");

    QQuickView view;
    view.resize(800, 400);
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl("qrc:///scenegraph/graph/main.qml"));
//    view.engine()->addImportPath();
    view.show();

    QTextStream stdOutStream(stdout);
    {

        auto * openglContext = view.openglContext();
        if (openglContext != nullptr)
        {
            auto extensions(openglContext->extensions());
            for (const QByteArray & currentExt : extensions)
                stdOutStream << "ext = " << currentExt
                             << endl;
        }

        stdOutStream << endl;

        auto printObjectProperties = [&stdOutStream](QObject * object_)
        {
            stdOutStream << "objectName = " << object_->objectName() << endl;
            if (object_->objectName() == QLatin1String("wellBar"))
            {
                qobject_cast<QQuickItem *>(object_)->setCursor(Qt::WaitCursor);

                WellBarHandler * h = new WellBarHandler(object_);
                QObject::connect(object_, SIGNAL(doubleClicked()),
                                 h, SLOT(onDoubleClicked()));
            }

            for (const QByteArray & propertyName : object_->dynamicPropertyNames())
            {
                stdOutStream << "propertyName = " << propertyName << endl;
            }

            stdOutStream << "id = " << QQmlProperty::read(object_, QLatin1String("id")).toString() << endl;

            stdOutStream << endl;

//            printObjectProperties(object_->children());
        };

        QQuickItem * root = view.rootObject();
        printObjectProperties(root);
        for (QObject * child : root->children())
            printObjectProperties(child);

    }

//	{
//		QMatrix4x4 m;
//		m.translate(0.5, -0.5);

//		qDebug() << m << endl;
//		qDebug() << m.column(3) << endl;
//	}

    return a.exec();
}

#include "main.moc"
