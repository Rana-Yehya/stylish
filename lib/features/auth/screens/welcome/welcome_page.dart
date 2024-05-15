import 'dart:async';
import 'package:stylish/core/constants/app_images.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        final authProvider = context.read<AuthController>();
        authProvider.currentSession();
        print(authProvider.userModel);
        if (authProvider.userModel != null) {
          context.pushReplacement("/main");
        } else {
          context.pushReplacement("/login");
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            image: const DecorationImage(
              image: AssetImage(AppImages.logo),
              fit: BoxFit.none,
            ),
          ),
        ),
      ),
    );
  }
}
