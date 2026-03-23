// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class SafeWebView extends StatelessWidget {
//   final String? url;
//   SafeWebView({this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: WebView(
//         initialUrl: url,
//       ),
//     );
//   }
// }
//
// WebView({String? initialUrl}) {
// }
//
//
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SafeWebView extends StatelessWidget {
  final String? url;
  const SafeWebView({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url ?? 'https://flutter.dev'));

    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
