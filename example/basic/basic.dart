import 'dart:html';
import 'dart:async';
import 'package:vdom/vdom.dart';

int count = 0;
VElement root;

void increment(){
  count += 1;
  rerender();
}

void rerender() {
  var next = create();
  root.update(next, const Context(true));
  root = next;
}

VHtmlGenericElement create() => new VHtmlGenericElement('div')(count.toString());

void main() {
   root = create();
   document.body.append(root.ref);
   root.attached();
   root.render(const Context(true));
   new Timer.periodic(const Duration(seconds: 1), (t){ increment(); });
}
