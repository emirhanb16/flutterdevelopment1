import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/bloc/client/client_cubit.dart';
import 'package:flutter_advanced_dev/bloc/products/products_cubit.dart';
import 'package:flutter_advanced_dev/core/localizations.dart';
import 'package:flutter_advanced_dev/core/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'bloc/cart/cart_cubit.dart';
import 'core/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ClientCubit(ClientState(darkMode: false, language: "en")),
        ),
        BlocProvider(
          create: (_) => CartCubit(
            CartState(sepet: []),
          ),
        ),
        BlocProvider(
          create: (_) => ProductsCubit(
            ProductsState(favorites: []),
          ),
        ),
      ],
      child: BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
          themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("en", "EN"),
            Locale("tr", "TR"),
            Locale("pl", "PL"),
          ],
          locale: Locale(state.language),
        );
      }),
    );
  }
}
