import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:url_launcher/url_launcher.dart';

import '../animations/hover_lift_and_rise.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              const Spacer(),
              Text(
                "Introducing",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "toTooooDoooo",
                  style: Theme.of(context) //
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 35.w),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.headline4!,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    const Text("A simple to-do app built"),
                    const Text(" with "),
                    Image.asset(
                      "assets/logos/appwrite.png",
                      width: 30,
                    ),
                    const Text(" Appwrite"),
                    const Text(" and "),
                    const FlutterLogo(size: 30),
                    const Text(" Flutter"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: OutlinedButton(
                  onPressed: () {
                    Routemaster.of(context).push("/login");
                  },
                  child: const Text("Get Started"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    HoverLiftAndRise(
                      child: GestureDetector(
                        onTap: () async {
                          await launch("https://github.com/appwrite/appwrite");
                        },
                        child: Image.asset(
                          "assets/logos/github.png",
                          width: 40,
                        ),
                      ),
                    ),
                    HoverLiftAndRise(
                      child: GestureDetector(
                        onTap: () async {
                          await launch("https://twitter.com/appwrite_io");
                        },
                        child: Image.asset(
                          "assets/logos/twitter.png",
                          width: 40,
                        ),
                      ),
                    ),
                    HoverLiftAndRise(
                      child: GestureDetector(
                        onTap: () async {
                          await launch("https://appwrite.io/");
                        },
                        child: Image.asset(
                          "assets/logos/appwrite.png",
                          width: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
