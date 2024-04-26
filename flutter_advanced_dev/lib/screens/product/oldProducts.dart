import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/client/client_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import '../../core/localizations.dart';

class oldProductsScreen extends StatefulWidget {
  const oldProductsScreen({Key? key}) : super(key: key);

  @override
  State<oldProductsScreen> createState() => _oldProductsScreenState();
}

class _oldProductsScreenState extends State<oldProductsScreen> {
  late CartCubit cartCubit;
  late ClientCubit clientCubit;
  late ProductsCubit productsCubit;

  var products = [
    {
      "id": 1,
      "name": "Samsung Galaxy S3",
      "price": 1200,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/81P-vCUKupL._AC_UF1000,1000_QL80_.jpg"
    },
    {
      "id": 2,
      "name": "FIFA 2006",
      "price": 450,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/51xqg0zoj7L._AC_UF1000,1000_QL80_.jpg"
    },
    {
      "id": 3,
      "name": "Iphone 5",
      "price": 3200,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/71hVVEE3Q7L._AC_UF1000,1000_QL80_.jpg"
    },
    {
      "id": 4,
      "name": "Dell / Dell Inspiron 9300 Laptop",
      "price": 3300,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/6198YZUmZ1S._AC_UF894,1000_QL80_.jpg"
    },
    {
      "id": 5,
      "name": "Samsung Galaxy Tab3 Lite",
      "price": 1100,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/41UZ4oZpryL._AC_UF1000,1000_QL80_.jpg"
    },
    {
      "id": 6,
      "name": "PlayStation 3",
      "price": 1250,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/61AlsXa+zdL._AC_UF1000,1000_QL80_.jpg"
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
        title: Text(AppLocalizations.of(context).getTranslate("old-products")),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                clientCubit.changeDarkMode(!clientCubit.state.darkMode);
              },
              icon: Icon(
                clientCubit.state.darkMode ? Icons.light_mode : Icons.dark_mode,
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
          )
        ],
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
                return Padding(
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
                                  products[productIndex]["price"].toString() +
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
                                          color: Colors.orange, // Turuncu renk
                                        ),
                                      ),
                                      content: Text(
                                        AppLocalizations.of(context)
                                            .getTranslate("add-to-card"),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: Colors.orange, // Turuncu renk
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                  GoRouter.of(context).pop(),
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
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.orange), // Turuncu renk
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => GoRouter.of(context).push("/home"),
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () => GoRouter.of(context).push("/search"),
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () => GoRouter.of(context).push("/settings"),
              icon: Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () => GoRouter.of(context).push("/product"),
              icon: Icon(Icons.shop_two),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
    );
  }
}
