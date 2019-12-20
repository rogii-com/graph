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
#include <cmath>

#include "graph.h"

#include <QtCore>

#include <QtQuick/QQuickWindow>

//#include "noisynode.h"
#include "gridnode.h"
#include "linenode.h"

const float gZoomFactor(0.01f);

Graph::Graph()
	: m_changed(false)
    , m_geometryChanged(false)
{
    setFlag(ItemHasContents, true);
	connect(this, &QQuickItem::windowChanged,
			this, &Graph::onWindowChanged);
}


void Graph::appendSample(qreal value)
{
    m_samples << value;
	m_changed = true;
    update();
}


void Graph::removeFirstSample()
{
    m_samples.removeFirst();
	m_changed = true;
	update();
}

void Graph::shiftScene(const int xStepInScreenPixels, const int yStepInScreenPixels)
{
//	qDebug() << Q_FUNC_INFO;



	//	const float ndcXZero(2.f * (0 - rightPart.x()) / rightPart.width() - 1.f);
	const float ndcXZero(-1.f);
	const float ndcYZero(1.f);

	const float ndcXStep(2.f * xStepInScreenPixels / width() - 1.f);
	const float ndcYStep(2.f * (height() - yStepInScreenPixels) / height() - 1.f);

	QLineF stepLine(mInverseVP.map(QPointF(ndcXZero, ndcYZero)),
					mInverseVP.map(QPointF(ndcXStep, ndcYStep)));

	//	qDebug() << "pos = " << e->pos()
	//			 << ", stepLine = " << stepLine
	//			 << ", dx = " << dx;

//	dx -= stepLine.dx();
	dy -= stepLine.dy();
	updateMatrices();
	update();
}

void Graph::addStaticRawLog()
{
    std::srand(static_cast<unsigned int>(QDateTime::currentDateTime().toMSecsSinceEpoch()));

    const std::size_t count = 1000;
    m_points.reserve(count);
    for (std::size_t i(0); i < count; ++i)
    {
        const double y = 0.1 * i;
        const double x = std::cos(y);

        const auto randomValue = 0.1 - 0.2 * std::rand() / RAND_MAX;
        m_points << QPointF(x + randomValue, y);
    }

	updateMatrices();
//	updateNDC();
	update();
}

void Graph::onWindowChanged(QQuickWindow * window)
{
	if (window == nullptr)
		return;

	connect(window, &QQuickWindow::heightChanged,
			this, &Graph::onWindowHeightChanged);
	connect(window, &QQuickWindow::widthChanged,
			this, &Graph::onWindowWidthChanged);
}

void Graph::onWindowHeightChanged(int windowHeight)
{
	m_NDCChanged = true;
	update();
}

void Graph::onWindowWidthChanged(int windowWidth)
{
	m_NDCChanged = true;
	update();
}

void Graph::updateMatrices()
{

	qDebug() << this << Q_FUNC_INFO;

	QMatrix4x4 newView;
	newView.translate(dx, dy);
	mView = newView;

	const float zoom(std::pow(2, zoomLevel));
	QMatrix4x4 newProjection;
//	newProjection.scale(zoom);
    newProjection.scale(1, zoom);
	mProjection = newProjection;

	bool invertable(false);
	mInverseVP = (mProjection * mView).inverted(&invertable);
	Q_ASSERT(invertable);

	m_VPChanged = true;
}

void Graph::geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry)
{
    m_geometryChanged = true;
    update();
    QQuickItem::geometryChanged(newGeometry, oldGeometry);

//	qDebug() << "new = " << newGeometry
//			 << ", old = " << oldGeometry
//			 << endl;
}

void Graph::wheelEvent(QWheelEvent * e)
{
	QQuickItem::wheelEvent(e);

//	QPair<QRect, QRect> parts(calculateParts());

//	const QRect & rightPart(parts.second);

//	const QRectF mappedRect = mapRectToItem(nullptr, QRectF(QPoint(0, 0),
//															QPoint(width(), height())));

//	const bool adjustView(rightPart.contains(e->pos()));
	const bool adjustView(true);

	const float ndcX(2.f * (e->pos().x() - 0) / width() - 1.f);
	const float ndcY(2.f * (height() - e->pos().y()) / height() - 1.f);

	QPointF oldWorldPosition(mInverseVP.map(QPointF(ndcX, ndcY)));
	// 1-y unit is 1/8 of degree
	zoomLevel += - (e->angleDelta().y() / 8) * gZoomFactor;

	qDebug() << "e->pos() = " << e->pos()
			 << ", ndc = " << QPointF(ndcX, ndcY)
			 << ";   oldWorldPosition = " << oldWorldPosition;

	if (adjustView)
	{
		const float zoom(std::pow(2, zoomLevel));
		QMatrix4x4 newProjection;
		newProjection.scale(zoom);

		bool invertable(false);
		QMatrix4x4 invVP((newProjection * mView).inverted(&invertable));
		Q_ASSERT(invertable);

		QPointF newWorldPosition(invVP.map(QPointF(ndcX, ndcY)));

//		qDebug() << "newWorldPosition = " << newWorldPosition
//				 << ", dx = " << dx
//				 << ", dy = " << dy
//				 << ", (oldWorldPosition.x() - newWorldPosition.x()) = " << (oldWorldPosition.x() - newWorldPosition.x());

//		dx -= (oldWorldPosition.x() - newWorldPosition.x());
		dy -= (oldWorldPosition.y() - newWorldPosition.y());
	}

	updateMatrices();
	update();
}

void Graph::mousePressEvent(QMouseEvent * e)
{
	QQuickItem::mousePressEvent(e);

	mLastPosition = gIncorrectPosition;
	if (Qt::LeftButton == e->buttons())
		mLastPosition = e->pos();

//	qDebug() << Q_FUNC_INFO;
}

void Graph::mouseReleaseEvent(QMouseEvent * e)
{
	QQuickItem::mouseReleaseEvent(e);

	if (Qt::LeftButton == e->button())
		mLastPosition = gIncorrectPosition;

//	qDebug() << Q_FUNC_INFO;
}

//void Graph::mouseMoveEvent(QMouseEvent * e)
//{
//	QQuickItem::mouseMoveEvent(e);

//	qDebug() << Q_FUNC_INFO;

//	if (Qt::LeftButton != e->buttons())
//		return;

//	if (gIncorrectPosition == mLastPosition)
//		return;

//	const int xStepInPixels(mLastPosition.x() - e->pos().x());
//	const int yStepInPixels(mLastPosition.y() - e->pos().y());
//	mLastPosition = e->pos();

////	const float ndcXZero(2.f * (0 - rightPart.x()) / rightPart.width() - 1.f);
//	const float ndcXZero(-1.f);
//	const float ndcYZero(1.f);

//	const float ndcXStep(2.f * xStepInPixels / width() - 1.f);
//	const float ndcYStep(2.f * (height() - yStepInPixels) / height() - 1.f);

//	QLineF stepLine(mInverseVP.map(QPointF(ndcXZero, ndcYZero)),
//					mInverseVP.map(QPointF(ndcXStep, ndcYStep)));

////	qDebug() << "pos = " << e->pos()
////			 << ", stepLine = " << stepLine
////			 << ", dx = " << dx;

//	dx -= stepLine.dx();
//	dy -= stepLine.dy();
//	updateMatrices();
//	update();
//}

class GraphNode : public QSGNode
{
public:
//    NoisyNode *background;
    GridNode *grid;
    LineNode *line;
    LineNode *shadow;
};


QSGNode *Graph::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    GraphNode *n= static_cast<GraphNode *>(oldNode);

    QRectF rect = boundingRect();
//	qDebug() << "rect = " << rect << endl;

    if (rect.isEmpty()) {
		qDebug() << Q_FUNC_INFO << " if (rect.isEmpty()) {";
        delete n;
        return 0;
    }

	auto calculateItemNDC([](QQuickItem * item)
	{
		Q_ASSERT(qFuzzyIsNull(item->rotation()));

		const QRectF mappedRect = item->mapRectToItem(nullptr, QRectF(QPoint(0, 0),
																	  QPoint(item->width(), item->height())));

		// intuitively =)
		const double halvedWidth(static_cast<double>(item->window()->width()) / 2);
		const double halvedHeight(static_cast<double>(item->window()->height()) / 2);
		QMatrix4x4 M_viewport(halvedWidth, 0, 0, halvedWidth,
							  0, halvedHeight, 0, halvedHeight,
							  0, 0, 1, 1,
							  0, 0, 0, 1);
		bool invertalbe(false);
		const QMatrix4x4 M_viewportInverse(M_viewport.inverted(&invertalbe));
		Q_ASSERT(invertalbe);

		// mappedRect - is in window coordinates. So map them to viewport coordinates
		// before mapping to NDC
		const QPointF topLeftInNDC = M_viewportInverse.map(QPointF(mappedRect.left(),
																   item->window()->height() - mappedRect.top()));
		const QPointF bottomRightInNDC = M_viewportInverse.map(QPointF(mappedRect.right(),
																	   item->window()->height() - mappedRect.bottom()));

		const QRectF rectInNDC = M_viewportInverse.mapRect(mappedRect);
		const QPointF topLeftInNDC1 = mappedRect.topLeft() * M_viewportInverse;
		const QPointF topLeftInNDC2 = M_viewportInverse * mappedRect.topLeft();
		const QPointF topLeftInNDC3 = M_viewportInverse.map(mappedRect.topLeft());

//		qDebug() << DUMPEXPRESSION(halvedWidth)
//				 << ", " << DUMPEXPRESSION(halvedHeight)
//				 << ", " << DUMPEXPRESSION(mappedRect)
//				 << ", " << DUMPEXPRESSION(rectInNDC)
//				 << ", " << DUMPEXPRESSION(topLeftInNDC1)
//				 << ", " << DUMPEXPRESSION(topLeftInNDC2)
//				 << ", " << DUMPEXPRESSION(topLeftInNDC3)
//				 << endl
//				 << DUMPEXPRESSION(topLeftInNDC)
//				 << ", " << DUMPEXPRESSION(bottomRightInNDC)
//				 << endl
//				 << DUMPEXPRESSION(M_viewport.map(QPointF(-1, -1)))
//				 << ", " << DUMPEXPRESSION(M_viewport.map(QPointF(1, 1)))
//				 << endl
//				 << ", " << DUMPEXPRESSION(M_viewportInverse.map(QPointF(0, 0)))
//				 << ", " << DUMPEXPRESSION(M_viewportInverse.map(QPointF(item->window()->width() - 1,
//																		 item->window()->height() - 1)))
//				 << endl;

		return QRectF(topLeftInNDC, bottomRightInNDC);
	});

    if (!n) {
        n = new GraphNode();

//        n->background = new NoisyNode(window());
		n->grid = new GridNode();
//        n->line = new LineNode(10, 0.5, QColor("steelblue"));
		n->line = new LineNode(10, 0.5, mLineColor);
		n->line->updateViewProjection(mProjection * mView);
//        n->shadow = new LineNode(20, 0.2f, QColor::fromRgbF(0.2, 0.2, 0.2, 0.4));
//		n->line->updateNormalizedDeviceCoordinates(calculateItemNDC(this));

//        n->appendChildNode(n->background);
		n->appendChildNode(n->grid);
//        n->appendChildNode(n->shadow);
		n->appendChildNode(n->line);
    }

	if (m_geometryChanged) {
//        n->background->setRect(rect);
		n->grid->setRect(rect);
	}

	if (m_geometryChanged || m_changed) {
//        n->line->updateGeometry(rect, m_samples);
		n->line->updateGeometry(m_points);
        // We don't need to calculate the geometry twice, so just steal it from the other one...
//        n->shadow->setGeometry(n->line->geometry());
    }

	if (m_NDCChanged)
		n->line->updateNormalizedDeviceCoordinates(calculateItemNDC(this));

	if (m_VPChanged)
		n->line->updateViewProjection(mProjection * mView);

	if (m_colorChanged)
		n->line->updateColor(mLineColor);

	m_colorChanged = false;
    m_geometryChanged = false;
	m_changed = false;
	m_NDCChanged = false;
	m_VPChanged = false;

    return n;
}
