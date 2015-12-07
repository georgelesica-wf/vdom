// Copyright (c) 2014, the VDom project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library vdom.svg.ellipse;

import 'dart:svg' as svg;
import '../context.dart';
import '../node.dart';
import 'shape.dart';

class VSvgEllipse extends VSvgShapeElement<svg.EllipseElement> {
  final int cx;
  final int cy;
  final int rx;
  final int ry;

  VSvgEllipse(
      {Object key,
       this.cx,
       this.cy,
       this.rx,
       this.ry,
       String transform,
       String color,
       String fill,
       num fillOpacity,
       num opacity,
       String stroke,
       num strokeOpacity,
       num strokeWidth,
       List<VNode> children,
       String id,
       String type,
       Map<String, String> attributes,
       List<String> classes,
       Map<String, String> styles})
      : super(
          key: key,
          transform: transform,
          color: color,
          fill: fill,
          fillOpacity: fillOpacity,
          opacity: opacity,
          stroke: stroke,
          strokeOpacity: strokeOpacity,
          strokeWidth: strokeWidth,
          children: children,
          id: id,
          type: type,
          attributes: attributes,
          classes: classes,
          styles: styles) {
    ref = new svg.EllipseElement();
  }

  void render(Context context) {
    super.render(context);

    if (cx != null) {
      ref.setAttribute('cx', cx.toString());
    }

    if (cy != null) {
      ref.setAttribute('cy', cy.toString());
    }

    if (rx != null) {
      ref.setAttribute('rx', rx.toString());
    }

    if (ry != null) {
      ref.setAttribute('ry', ry.toString());
    }
  }

  void update(VSvgEllipse other, Context context) {
    super.update(other, context);

    if (cx != other.cx) {
      ref.setAttribute('cx', other.cx.toString());
    }

    if (cy != other.cy) {
      ref.setAttribute('cy', other.cy.toString());
    }

    if (rx != other.rx) {
      ref.setAttribute('rx', other.rx.toString());
    }

    if (ry != other.ry) {
      ref.setAttribute('ry', other.ry.toString());
    }
  }
}
