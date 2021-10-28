import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:movi/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatefulWidget {

String title;
WebViewScreen(this.title);
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
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
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          centerTitle: true,
          elevation: 3,
          title: Text(
            "${widget.title}",
            style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
          ),
         leading: IconButton(onPressed: () {
           Navigator.pop(context);
         },
           icon: Icon(Icons.arrow_back_ios,color: primarycolor,),
         ),
        ),
body: SafeArea(
    child: Column(children: <Widget>[
      TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search)
        ),
        controller: urlController,
        keyboardType: TextInputType.url,
        onSubmitted: (value) {
          var url = Uri.parse(value);
          if (url.scheme.isEmpty) {
            url = Uri.parse("https://faze.egybest.pet/movie/${widget.title}");
          }
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: url));
        },
      ),
      Expanded(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest:
              URLRequest(url: Uri.parse("https://faze.egybest.pet/movie/${widget.title}")),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              androidOnPermissionRequest: (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;

                if (![ "http", "https", "file", "chrome",
                  "data", "javascript", "about"].contains(uri.scheme)) {
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
                  urlController.text = this.url;
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
                  urlController.text = this.url;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container(),
          ],
        ),
      ),

    ]))),

      );
    
  }
}
