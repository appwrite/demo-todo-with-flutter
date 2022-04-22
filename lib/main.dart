import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'authentication/authentication_provider.dart';
import 'utils/routing.dart';
import 'utils/themes.dart';

Future<void> main() async {
  await dotenv.load();

  Routemaster.setPathUrlStrategy();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider);

    return ScreenUtilInit(
      builder: () => MaterialApp.router(
        routeInformationParser: const RoutemasterParser(),
        routerDelegate: RoutemasterDelegate(
          routesBuilder: (_) => buildRoutes(isLoggedIn: userId != null),
        ),
        title: 'Flutter Demo',
        theme: appTheme(),
      ),
    );
  }
}
