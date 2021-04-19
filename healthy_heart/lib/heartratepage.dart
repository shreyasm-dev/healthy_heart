import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HeartratePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IFrameElement iframe = IFrameElement();
    iframe.src = 'https://shreyasm-dev.github.io/heartbeat-js/';
    iframe.allow = 'camera *;';
    iframe.style.border = 'none';
    iframe.width = '100%';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => iframe,
    );

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: HtmlElementView(
          key: UniqueKey(),
          viewType: 'iframeElement',
        ),
      ),
    );
  }
}
