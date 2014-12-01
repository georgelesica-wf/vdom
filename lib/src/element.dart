// Copyright (c) 2014, the VDom project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of vdom;

abstract class ElementBase<T extends html.Element> extends Node<T> {
  String id;
  Map<String, String> attributes;
  List<String> classes;
  Map<String, String> styles;

  ElementBase(Object key, this.id, this.attributes, this.classes, this.styles)
       : super(key);

  void render(Context context) {
    if (id != null) {
      ref.id = id;
    }
    if (attributes != null) {
      attributes.forEach((key, value) {
        ref.setAttribute(key, value);
      });
    }
    if (styles != null) {
      styles.forEach((key, value) {
        ref.style.setProperty(key, value);
      });
    }
    if (classes != null) {
      ref.classes.addAll(classes);
    }
  }

  void update(ElementBase other, Context context) {
    super.update(other, context);
    if (other.id == null) {
      other.id = id;
    } else if (id != other.id) {
      ref.id = other.id;
    }
    if (attributes != null || other.attributes != null) {
      updateMap(attributes, other.attributes, ref.attributes);
    }
    if (styles != null || other.styles != null) {
      updateStyle(styles, other.styles, ref.style);
    }
    if (classes != null || other.classes != null) {
      updateSet(classes, other.classes, ref.classes);
    }
  }
}

abstract class ElementContainerBase<T extends html.Element> extends ElementBase<T> with Container<T> {
  /// Element children
  List<Node> children;

  html.Element get container => ref;

  ElementContainerBase(Object key,
      this.children,
      String id,
      Map<String, String> attributes,
      List<String> classes,
      Map<String, String> styles)
      : super(key, id, attributes, classes, styles);

  ElementContainerBase<T> call(children) {
    if (children is List) {
      this.children = children;
    } else if (children is String) {
      this.children = [new Text(children)];
    } else {
      this.children = [children];
    }
    return this;
  }

  void update(ElementContainerBase other, Context context) {
    super.update(other, context);
    if (children != null || other.children != null) {
      updateChildren(children, other.children, context);
    }
  }

  /// Mount on top of existing element
  void render(Context context) {
    super.render(context);
    if (children != null) {
      renderChildren(children, context);
    }
  }

  void detached() {
    if (children != null) {
      for (var i = 0; i < children.length; i++) {
        children[i].detached();
      }
    }
  }
}

/// Virtual Dom Element
class Element extends ElementContainerBase<html.Element> {
  /// [Element] tag name
  final String tag;

  /// Create a new [Element]
  Element(this.tag,
      {Object key,
       List<Node> children,
       String id,
       Map<String, String> attributes,
       List<String> classes,
       Map<String, String> styles})
      : super(key, children, id, attributes, classes, styles);

  void create(Context context) {
    ref = html.document.createElement(tag);
  }

  bool sameType(Node other) => super.sameType(other) && tag == (other as Element).tag;

  String toString() => '<$tag key="$key">${children.join()}</$tag>';
}
