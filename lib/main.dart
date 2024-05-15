import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/route_controller.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://puobkhhvvespdletdxdp.supabase.co",
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1b2JraGh2dmVzcGRsZXRkeGRwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQzODg3ODgsImV4cCI6MjAyOTk2NDc4OH0.ELmPCe9a-5PNt0NZVlf3U6iCKAeQ3XFibhgyWG3pBd4',
  );
  configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return ChangeNotifierProvider(
          create: (_) => getIt<AuthController>(),
          child: MaterialApp.router(
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              appBarTheme: AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: AppColors.black,
                ),
              ),
              useMaterial3: true,
            ),
            routerConfig: router,

            //routeInformationParser: router.routeInformationParser,
            //routeInformationProvider: router.routeInformationProvider,
          ),
        );
      },
    );
  }
}
