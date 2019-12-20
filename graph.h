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

#ifndef GRAPH_H
#define GRAPH_H

#define DUMPEXPRESSION(expression) #expression << " = " << (expression)

#include <limits>

#include <QQuickItem>

#include <QtGui/QMatrix4x4>

const QPoint gIncorrectPosition(std::numeric_limits<int>::min(),
								std::numeric_limits<int>::min());

class Graph : public QQuickItem
{
    Q_OBJECT

	Q_PROPERTY(QColor lineColor READ getLineColor WRITE setLineColor NOTIFY lineColorChanged)

public:
    Graph();

	QColor getLineColor() const
	{
		return mLineColor;
	}

protected:
    QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);
    void geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry);
	void wheelEvent(QWheelEvent * e) override;
	void mousePressEvent(QMouseEvent * e) override;
	void mouseReleaseEvent(QMouseEvent * e) override;
//	void mouseMoveEvent(QMouseEvent * e) override;

Q_SIGNALS:
	void lineColorChanged(const QColor newLineColor);

public slots:
    void appendSample(qreal value);
    void removeFirstSample();

	void append(const QPointF point_)
	{
		m_points << point_;
		m_changed = true;
		update();
	}

	void resetViewMatrix()
	{
		qDebug() << Q_FUNC_INFO;
		dx = 0;
		dy = 0;
		updateMatrices();
		update();
	}

	void resetProjectionMatrix()
	{
		qDebug() << Q_FUNC_INFO;
		zoomLevel = 0;
		updateMatrices();
		update();
	}

	void resetVP()
	{
		qDebug() << Q_FUNC_INFO;
		zoomLevel = 0;
		dx = 0;
		dy = 0;
		updateMatrices();
		update();
	}

	void shiftScene(const int xStepInScreenPixels,
					const int yStepInScreenPixels);

	void setLineColor(QColor newColor)
	{
		if (mLineColor == newColor)
			return;

		m_colorChanged = true;
		mLineColor = newColor;
		Q_EMIT(lineColorChanged(mLineColor));
		update();
	}

	void updateNDC()
	{
		qDebug() << Q_FUNC_INFO;

		m_NDCChanged = true;
		update();
	}

	void addStaticRawLog();

private Q_SLOTS:
	void onWindowChanged(QQuickWindow * window);
	void onWindowHeightChanged(int windowHeight);
	void onWindowWidthChanged(int windowWidth);

private:
	void updateMatrices();

private:
    QList<qreal> m_samples;
	QList<QPointF> m_points;

	bool m_changed;
    bool m_geometryChanged;
	bool m_NDCChanged = true;

	QMatrix4x4 mView = QMatrix4x4();
	QMatrix4x4 mProjection = QMatrix4x4();
	QMatrix4x4 mInverseVP = QMatrix4x4();

	double zoomLevel = 0;
	double dx = 0;
	double dy = 0;

	bool m_VPChanged = true;

	QPoint mLastPosition = gIncorrectPosition;
	QColor mLineColor = QColor("steelblue");
	bool m_colorChanged = true;
};

#endif // GRAPH_H
