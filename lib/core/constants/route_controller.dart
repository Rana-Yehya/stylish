import 'package:stylish/features/auth/screens/forgot_password/forgot_password_page.dart';
import 'package:stylish/features/auth/screens/login/login_page.dart';
import 'package:stylish/features/auth/screens/password_verification/password_verification_page.dart';
import 'package:stylish/features/auth/screens/register/register_page.dart';
import 'package:stylish/features/auth/screens/verification/verification_page.dart';
import 'package:stylish/features/payment/screens/payment_screen.dart';
import 'package:stylish/features/location/screens/access_location_page.dart';
import 'package:stylish/features/location/screens/map_with_location_screen.dart';
import 'package:stylish/features/main/data/models/product_model.dart';
import 'package:stylish/features/main/screens/main_screen.dart';
import 'package:stylish/features/auth/screens/welcome/welcome_page.dart';
import 'package:stylish/features/product_view/presentation/screens/product_view_page.dart';
import 'package:stylish/features/search/presentation/screens/search_page.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'initial',
      builder: (context, state) => const WelcomePage(),
      routes: [
        GoRoute(
          path: 'login',
          name: "login",
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: "forgot_password",
          name: "forgotPassword",
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: "register",
          name: "register",
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: "access_location",
          name: "access_location",
          builder: (context, state) => const AccessLocationPage(),
        ),
        GoRoute(
          path: "verification",
          name: "verification",
          builder: (context, state) => const VerificationPage(),
        ),
        GoRoute(
          path: "password_verification",
          name: "password_verification",
          builder: (context, state) => const PasswordVerificationPage(),
        ),
        GoRoute(
          path: "main",
          name: "main",
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: "map_with_location",
          name: "map_with_location",
          builder: (context, state) => const MapWithLocationScreen(),
        ),
        GoRoute(
            path: "payment",
            name: "payment",
            builder: (context, state) {
              Map<String, dynamic> sample = state.extra as Map<String, dynamic>;
              return PaymentScreen(
                productModel: sample['productModel'],
                color: sample['color'],
                size: sample['size'],
                quantity: sample['quantity'],
              );
            }),
        GoRoute(
          path: 'search',
          name: 'search',
          builder: (context, state) {
            Map<String, dynamic> sample = state.extra as Map<String, dynamic>;
            return SearchPage(
              category: sample["category"],
              isSale: sample["isSale"],
            );
          },
        ),
        GoRoute(
          path: "product_view",
          name: "product_view",
          builder: (context, state) {
            Map<String, ProductModel> sample =
                state.extra as Map<String, ProductModel>;
            return ProductViewPage(productModel: sample["productModel"]!);
          },
        ),
      ],
    ),
  ],
);
