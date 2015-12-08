library vdom.src.render;

import 'dart:html' as html;

import 'package:vdom/src/context.dart';
import 'package:vdom/src/node.dart';

VNode render(VNode component, html.Element container) {
  html.document.body.append(component.ref);
  component.flush(const Context(true));
  return component;
}
