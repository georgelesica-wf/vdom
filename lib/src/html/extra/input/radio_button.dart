// Copyright (c) 2014, the VDom project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library vdom.html.extra.input.radio_button;

import 'dart:html' as html;
import 'checked_input_base.dart';

/// Virtual Html Element `<input type="radio">`
class VRadioButton extends VCheckedInputBase {
  VRadioButton({
    Object key,
    bool checked,
    bool disabled,
    String id,
    String type,
    Map<String, String> attributes,
    List<String> classes,
    Map<String, String> styles})
    : super(
        key: key,
        checked: checked,
        disabled: disabled,
        id: id,
        type: type,
        attributes: attributes,
        classes: classes,
        styles: styles) {
    ref = new html.InputElement(type: 'radio');
  }
}
