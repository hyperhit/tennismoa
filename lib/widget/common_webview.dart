import 'dart:collection';
import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonWebView extends StatefulWidget {
  final String siteUrl;

  const CommonWebView({Key? key, required this.siteUrl}) : super(key: key);

  @override
  _CommonWebViewState createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {},
        onHideContextMenu: () {},
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid) ? contextMenuItemClicked.androidId : contextMenuItemClicked.iosId;
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.lightGreen,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController!.canGoBack()) {
          webViewController?.goBack();
          return false; //stay in app
        } else {
          return true; //leave app
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                // contextMenu: contextMenu,
                initialUrlRequest: URLRequest(url: Uri.parse(widget.siteUrl)),
                initialUserScripts: UnmodifiableListView<UserScript>([]),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {},
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
                    if (await canLaunch(url)) {
                      // Launch the App
                      await launch(
                        url,
                      );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {},
                onEnterFullscreen: (webViewController) {
                  AutoOrientation.landscapeAutoMode();
                },
                onExitFullscreen: (webViewController) {
                  AutoOrientation.portraitAutoMode();
                },
              ),
              /*
              progress < 1.0
                  ? LinearProgressIndicator(
                      value: progress,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                      minHeight: 3,
                    )
                  : Container(),

               */
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await webViewController!.canGoBack()) {
              webViewController?.goBack();
            }
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
          backgroundColor: Colors.green.withOpacity(0.9),
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // ButtonBar(
        //   alignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     ElevatedButton(
        //       child: Icon(Icons.arrow_back),
        //       onPressed: () {
        //         webViewController?.goBack();
        //       },
        //     ),
        //     ElevatedButton(
        //       child: Icon(Icons.arrow_forward),
        //       onPressed: () {
        //         webViewController?.goForward();
        //       },
        //     ),
        //     ElevatedButton(
        //       child: Icon(Icons.refresh),
        //       onPressed: () {
        //         webViewController?.reload();
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
