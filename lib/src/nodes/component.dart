// Copyright (c) 2014, the VDom project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of vdom.internal;

abstract class ComponentBase {
  /// Fast check to detect if the Component is changed.
  bool isChanged(ComponentBase other);

  /// Build Component subtree.
  Element build();
}

abstract class Component extends Node with ComponentBase {
  Element _element;

  Component(Object key) : super(key);

  ElementPatch diff(Component other) {
    if (isChanged(other)) {
      if (other._element == null) {
        other._element = other.build();
      }
      return _element.diff(other._element);
    }
    return null;
  }

  html.Node render() {
    assert(_element != null);

    return _element.render();
  }
}

class DelegatingComponent extends Component {
  final ComponentBase _component;

  DelegatingComponent(this._component, Object key) : super(key);

  bool isChanged(ComponentBase other) {
    return _component.isChanged(other);
  }

  Element build() {
    return _component.build();
  }
}