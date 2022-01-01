import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen({Key? key}) : super(key: key);

  final Future<String> _version =
      PackageInfo.fromPlatform().then((info) => info.version);
  final _bugReportLink = 'https://github.com/rovati/exp-app/issues';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.66,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Thank you for checking out the alpha version of this app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RichText(
                  text: TextSpan(
                    text: 'Report a bug',
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launch(_bugReportLink);
                      },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FutureBuilder<String>(
                  future: _version,
                  builder: (context, snapshot) {
                    var version = 'retreiving app version...';
                    if (snapshot.hasData) {
                      version = 'v' + snapshot.data!;
                    }
                    if (snapshot.hasError) {
                      version = 'failed to retreive the app version';
                    }
                    return Text(
                      version,
                      style: const TextStyle(fontSize: 10, color: Colors.blue),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
