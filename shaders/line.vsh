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

attribute highp vec4 pos;
attribute highp float t;

uniform lowp float size;
uniform highp mat4 qt_Matrix;
uniform highp vec2 ndcBottomLeft;
uniform highp vec2 ndcTopRight;

uniform highp mat4 VP;

varying lowp float vT;

void main(void)
{
    vec4 adjustedPos = pos;
    adjustedPos.y += (t * size);

        mat4 view = mat4(1.0);
        view[3] = vec4(0.5, -0.5, 0.0, 1.0);

//    const mat4 view = mat4(
//                // first column
//                0.0025, 0.0, 0.0, 0.0,
//                // second
//                0.0, -0.005, 0.0, 0.0,
//                // third
//                0.0, 0.0, 1.0, 0.0,
//                // forth
//                0.0, 0.0, 0.0, 1.0
//                );

//    const float xMin = -0.75;
//    const float xMax = -0.25;

//    const float yMin = 0.3;
//    const float yMax = 0.55;
    float xMin = ndcBottomLeft.x;
    float xMax = ndcTopRight.x;

    float yMin = ndcBottomLeft.y;
    float yMax = ndcTopRight.y;

    vec4 interPos = VP * pos;

    interPos.x = 0.5 * ((1.0 - interPos.x) * xMin + (1.0 + interPos.x) * xMax);
    interPos.y = 0.5 * ((1.0 - interPos.y) * yMin + (1.0 + interPos.y) * yMax);

    gl_Position = interPos;

//    gl_Position = qt_Matrix * adjustedPos;
//    gl_Position = view * pos;

    // just for shader compiler not to eliminate qt_Matrix
    vT = t * qt_Matrix[0][0];
}
