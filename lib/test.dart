import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'test',
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late InAppWebViewController _controller;
  double _htmlheight = 200;
  // the purpose is to display 200 height content directly after the callback is completed, so as to improve the user experience

  static const String HANDLER_NAME = 'InAppWebView';

  @override
  void dispose() {
    super.dispose();
    _controller?.removeJavaScriptHandler(handlerName: 'InAppWebView');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Title'),
            Container(
              // wrap WebView with a container that can provide height and set it as the height of the callback
              height: _htmlheight,
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse('https://flutter.dev/')),
                onWebViewCreated: (InAppWebViewController controller) {
                  _controller = controller;
                  _setJSHandler(_controller); // set the JS method back to get the height
                },
                onLoadStop: (controller, url) {
                  //Inject JS method after page loading to obtain the total height of the page
                  controller.addJavaScriptHandler("""
         window.flutter_inappbrowser.callHandler('InAppWebView', document.body.scrollHeight));
        """);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _setJSHandler(InAppWebViewController controller) {
    JavaScriptHandlerCallback callback = (List<dynamic> arguments) async {
      //Analyze the argument, get the height, and set it directly (iPhone needs + 20 height)
      double height = HtmlUtils.getHeight(arguments);
      if (height > 0) {
        setState(() {
          _htmlHeight = height;
        });
      }
    };
    controller.addJavaScriptHandler(HANDLER_NAME, callback);
  }
}
