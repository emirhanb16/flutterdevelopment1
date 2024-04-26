import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/client/client_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import '../../core/localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CartCubit cartCubit;
  late ClientCubit clientCubit;
  late ProductsCubit productsCubit;

  var products = [
    {
      "id": 1,
      "name": "Samsung Galaxy Tab s6 Lite",
      "price": 14400,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/61Kc3oAQYaL._AC_UF1000,1000_QL80_.jpg"
    },
    {
      "id": 2,
      "name": "LG 49UM7100PLB Ultra HD 4K",
      "price": 47250,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/71jHf4u2HEL._AC_UF350,350_QL80_.jpg"
    },
    {
      "id": 3,
      "name": "HP DeskJet 2710",
      "price": 8640,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/61Qq5QgehWL._AC_UF1000,1000_QL80_.jpg"
    },
  ];

  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    productsCubit = context.read<ProductsCubit>();
    cartCubit = context.read<CartCubit>();
    clientCubit = context.read<ClientCubit>();
  }

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).getTranslate("language")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: clientCubit.state.language != "en"
                    ? () {
                        clientCubit.changeLanguage("en");
                      }
                    : null,
                child: Text("English"),
              ),
              ElevatedButton(
                onPressed: clientCubit.state.language != "tr"
                    ? () {
                        clientCubit.changeLanguage("tr");
                      }
                    : null,
                child: Text("Türkçe"),
              ),
              ElevatedButton(
                onPressed: clientCubit.state.language != "pl"
                    ? () {
                        clientCubit.changeLanguage("pl");
                      }
                    : null,
                child: Text("Polski"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslate("home_title")),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
                clientCubit.changeDarkMode(!clientCubit.state.darkMode);
              },
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => showLanguageDialog(context),
              icon: Icon(Icons.language),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).push("/favorites"),
              icon: Icon(Icons.favorite),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).push("/cart"),
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title:
                  Text(AppLocalizations.of(context).getTranslate("settings")),
              onTap: () {
                GoRouter.of(context).push('/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.shop_two),
              title:
                  Text(AppLocalizations.of(context).getTranslate("products")),
              onTap: () {
                GoRouter.of(context).push('/product');
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text(AppLocalizations.of(context).getTranslate("profile")),
              onTap: () {
                // Profil sayfasına yönlendirme yapılacak.
                GoRouter.of(context).push('/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text(
                  AppLocalizations.of(context).getTranslate("old-products")),
              onTap: () {
                GoRouter.of(context).push('/oldproducts');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(AppLocalizations.of(context).getTranslate("logout")),
              onTap: () {
                GoRouter.of(context).push('/login');
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return SizedBox.expand(
            child: ListView.builder(
              itemCount: (products.length / 3).ceil(),
              itemBuilder: (context, rowIndex) {
                int startIndex = rowIndex * 3;
                int endIndex = (rowIndex + 1) * 3;
                if (endIndex > products.length) {
                  endIndex = products.length;
                }
                String? discountTitle = rowIndex == 0
                    ? AppLocalizations.of(context).getTranslate("10-discount")
                    : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (discountTitle !=
                        null) // Display the discount title if it's not null
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          discountTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(endIndex - startIndex, (index) {
                          var productIndex = startIndex + index;
                          return Expanded(
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.network(
                                    products[productIndex]["photo"].toString(),
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      products[productIndex]["name"].toString(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange, // Turuncu renk
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      products[productIndex]["price"]
                                              .toString() +
                                          " ₺",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.orange, // Turuncu renk
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      cartCubit.sepeteEkle(
                                        id: products[productIndex]["id"] as int,
                                        photo: products[productIndex]["name"]
                                            .toString(),
                                        ad: products[productIndex]["name"]
                                            .toString(),
                                        sayi: 1,
                                        fiyat: products[productIndex]["price"]
                                            as double,
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            AppLocalizations.of(context)
                                                .getTranslate("cart"),
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Colors.orange, // Turuncu renk
                                            ),
                                          ),
                                          content: Text(
                                            AppLocalizations.of(context)
                                                .getTranslate("add-to-card"),
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color:
                                                  Colors.orange, // Turuncu renk
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      GoRouter.of(context)
                                                          .push("/cart"),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .getTranslate(
                                                            "go-to-basket"),
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Colors
                                                          .orange, // Turuncu renk
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      GoRouter.of(context)
                                                          .pop(),
                                                  child: Text(" X "),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .getTranslate("add-to-basket"),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orange), // Turuncu renk
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
