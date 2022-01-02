import 'package:exp/util/constant/paths_and_links.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget representing an info page, where a brief desccription of the app is
/// given together with other app details such as the version.
class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  // REVIEW move strings to constants
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
              Text(
                Strings.appDesc,
                textAlign: TextAlign.center,
                style: TextStyles.blue25,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RichText(
                  text: TextSpan(
                    text: Strings.reportBug,
                    style: TextStyles.blueU,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch(PathOrLink.bugReportLink);
                      },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FutureBuilder<String>(
                  future: Strings.appVersion,
                  builder: (context, snapshot) {
                    var version = Strings.retrievingAppV;
                    if (snapshot.hasData) {
                      version = snapshot.data! + Strings.buildType;
                    }
                    if (snapshot.hasError) {
                      version = Strings.failRetrieveAppV;
                    }
                    return Text(
                      version,
                      style: TextStyles.blue10,
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
