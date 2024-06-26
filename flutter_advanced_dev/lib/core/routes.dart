// import 'package:flutter_advanced_dev/core/loader.dart';
import 'package:flutter_advanced_dev/screens/client/login.dart';
import 'package:flutter_advanced_dev/screens/product/product.dart';
import 'package:flutter_advanced_dev/screens/static/boarding.dart';
import 'package:go_router/go_router.dart';

import '../screens/client/profile.dart';
import '../screens/client/register.dart';
import '../screens/client/static/about.dart';
import '../screens/client/static/contact.dart';
import '../screens/core/error.dart';
import '../screens/core/settings.dart';
import '../screens/home.dart';
import '../screens/product/cart.dart';
import '../screens/product/favorites.dart';
import '../screens/product/oldProducts.dart';
import '../screens/product/search.dart';

// GoRouter configuration
final routes = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) => const ProductScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/boarding',
      builder: (context, state) => const BoardingScreen(),
    ),
    GoRoute(
      path: '/oldproducts',
      builder: (context, state) => const oldProductsScreen(),
    ),
  ],
);
