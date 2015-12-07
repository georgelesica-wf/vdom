// Copyright (c) 2014, the VDom project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library vdom.html.extra.url_input;

import 'dart:html' as html;
import 'text_input_base.dart';

/// Virtual Html Element `<input type="url">`
class VUrlInput extends VTextInputBase {
  VUrlInput({
    Object key,
    String value,
    bool disabled,
    String placeholder,
    int maxLength,
    bool autofocus,
    String id,
    String type,
    Map<String, String> attributes,
    List<String> classes,
    Map<String, String> styles})
    : super(
        key: key,
        value: value,
        disabled: disabled,
        placeholder: placeholder,
        maxLength: maxLength,
        autofocus: autofocus,
        id: id,
        type: type,
        attributes: attributes,
        classes: classes,
        styles: styles) {
    ref = new html.InputElement(type: 'url');
  }
}
