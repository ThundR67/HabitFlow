import 'package:flutter/material.dart';

import 'package:habitflow/resources/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Displays webview to show faq about the app.
class FAQ extends StatefulWidget {
  /// Constructs.
  const FAQ();

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(faqPage),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLoading) const LinearProgressIndicator(),
          Expanded(
            child: WebView(
              initialUrl: 'https://thundrx.pythonanywhere.com/faq',
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
