// Copyright (c) 2014, the VDom project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library vdom.node;

import 'dart:html' as html;
import 'context.dart';

/// Abstract [VNode] class
///
/// Lifecycle:
/// - create() -> init() -> attached() -> render() -> update() -> detached()
/// - mount() -> init() -> attached() -> update() -> detached()
abstract class VNode<T extends html.Node> {
  /// Key is used in matching algorithm to identify node positions in children
  /// lists.
  ///
  /// Key should be unique amongst its siblings.
  final Object key;

  /// Reference to the actual html Node.
  T ref;

  /// [VNode] constructor.
  VNode(this.key);

  /// Mount on top of existing html Node
  void mount(T node, Context context) { this.ref = node; }

  /// Render attributes, styles, classes, children, etc.
  void render(Context context) {}

  /// Update attributes, styles, clasess, children, etc.
  void update(VNode other, Context context) { other.ref = ref; }

  /// Remove node
  void dispose(Context context) {
    ref.remove();
  }

  /// Check if [other] [VNode] has the same type and it can be updated,
  /// it is used when children list is using implicit keys.
  bool sameType(VNode other) => runtimeType == other.runtimeType;
}
