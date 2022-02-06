import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebView extends StatefulWidget {
  final String siteUrl;
  const CommonWebView({Key? key, required this.siteUrl}) : super(key: key);

  @override
  _CommonWebViewState createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  final _key = UniqueKey();
  late WebViewController controller;
  late bool _isLoadingPage;
  late bool _isFinished;

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
    _isFinished = false;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false; //stay in app
        } else {
          return true; //leave app
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: _isFinished ? 1 : 0,
              child: WebView(
                key: _key,
                initialUrl: widget.siteUrl,
                javascriptMode: JavascriptMode.unrestricted,
                gestureRecognizers: Set()
                  ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                onWebViewCreated: (webviewController) {
                  controller = webviewController;
                },
                onPageFinished: (finish) {
                  setState(() {
                    _isLoadingPage = false;
                    _isFinished = true;
                  });
                },
              ),
            ),
            _isLoadingPage
                ? const Scaffold(
                    body: Align(
                      alignment: Alignment.topLeft,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                        minHeight: 3,
                      ),
                    ),
                  )
                : Stack()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await controller.canGoBack()) {
              controller.goBack();
            }
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
          backgroundColor: Colors.grey.withOpacity(0.8),
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
