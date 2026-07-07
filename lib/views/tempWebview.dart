import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/webViewController.dart';
import 'package:real_birth_app/models/articleModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';



class WebViewExample extends StatefulWidget {
  final Articlemodel link;
  const WebViewExample({super.key, required this.link});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;
  final webViewController web = webViewController();
  late DateTime currTime;
  final initTime  = DateTime.now();
  
  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
  
    final controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.link.link));
        _controller = controller;
  }
//Create log
  @override
  void dispose() {
    currTime = DateTime.now();
    web.checkIfRevisit(initTime, currTime, widget.link.key);
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: WebViewWidget(controller: _controller),
    ) ,
      );
  }
}
