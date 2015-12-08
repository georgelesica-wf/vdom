library vdom.src.component;

import 'dart:html' as html;

import 'element.dart';
import 'package:vdom/src/node.dart';
import 'package:vdom/src/utils/container.dart';
import 'package:vdom/src/text.dart';
import 'package:vdom/src/context.dart';

// TODO: What should this return?
typedef dynamic ElementFactory(Map props, [dynamic children]);
typedef Component ComponentFactory();

ElementFactory registerComponent(ComponentFactory factory) {
  return (Map props, [dynamic children]) {
    var component = factory()
      .._setChildren(children)
      .._setProps(props);
    return component.render();
  };
}

abstract class Component<T extends html.Element> extends VNode<T> with Container<T> {
  Map props;
  Map state;
  List<VNode> children;

  String get key => props['key'];
  String get id => props['id'];
  Map<String, String> get attributes => props['attributes'];
  List<String> get classes => props['classes'];
  Map<String, String> get styles => props['styles'];

  html.Element get container => ref;

  // TODO: Refactor base [VNode] to not require the key in its constructor.
  Component() : super(null);

  // Setup stuff.

  void _setChildren(dynamic children) {
    if (children is List) {
      this.children = children;
    } else if (children is Iterable) {
      this.children = children.toList();
    } else if (children is String) {
      this.children = [new VText(children)];
    } else {
      this.children = [children];
    }
  }

  void _setProps(Map props) {
    this.props = props;
  }

  // React-alike methods

  VNode render() {}

  // Old vdom stuff.

  void flush(Context context) {
      if (id != null) {
          ref.id = id;
      }

      if (type != null) {
          ref.classes.add(type);
      }

      if (attributes != null) {
          attributes.forEach((k, v) {
              ref.setAttribute(k, v);
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

      if (children != null) {
          renderChildren(children, context);
      }
  }

  void update(VElement other, Context context) {
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

      if (children != null || other.children != null) {
          updateChildren(children, other.children, context);
      }
  }

  bool sameType(VNode other) =>
      super.sameType(other) && type == (other as VElement).type;
}
