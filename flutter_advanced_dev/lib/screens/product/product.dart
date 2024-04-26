import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/client/client_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import '../../core/localizations.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late CartCubit cartCubit;
  late ClientCubit clientCubit;
  late ProductsCubit productsCubit;

  var products = [
    {
      "id": 1,
      "name": "MacBook 2024 pro M2",
      "price": 48000.00,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/61CHqS31PiL._AC_UF1000,1000_QL80_.jpg"
    },
    {
      "id": 2,
      "name": "Casper Excalibur",
      "price": 0,
      "in-stock": false,
      "photo":
          "https://m.media-amazon.com/images/I/617gtzgU-uL._AC_UF1000,1000_QL80_.jpg"
    },
    {
      "id": 3,
      "name": "Samsung Galaxy S8 Edge",
      "price": 22500.00,
      "in-stock": true,
      "photo":
          "https://static.wixstatic.com/media/fcada6_f02798e57c7a40d6bd9b3fc60ab79ba1~mv2.jpg/v1/fill/w_479,h_462,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/fcada6_f02798e57c7a40d6bd9b3fc60ab79ba1~mv2.jpg"
    },
    {
      "id": 4,
      "name": "Huawei P40 Pro",
      "price": 16000.00,
      "in-stock": true,
      "photo": "https://m.media-amazon.com/images/I/71kygPBxq7L.jpg"
    },
    {
      "id": 5,
      "name": "Samsung Galaxy A72",
      "price": 43000.00,
      "in-stock": true,
      "photo":
          "https://cdn.qukasoft.com/f/386088/b2NpVUoyVXA3TFZ3SzJGdEg4MXZKZWxESUE9PQ/p/samsung-galaxy-a72-kilif-aynali-desenli-kamera-korumali-parlak-lopard-mirror-kapak-17189-0.webp"
    },
    {
      "id": 6,
      "name": "Asus Vivobook",
      "price": 0,
      "in-stock": false,
      "photo":
          "https://cdn03.ciceksepeti.com/cicek/kcm14666300-1/XL/asus-vivobook-15-x1502za-ej1071-intel-core-i5-1235u-8gb-256gb-ssd-15.6-freedos-tasinabilir-bilgisayar-kcm14666300-1-b55cb24aa72f4e76b19d0a0d81cd0215.jpg"
    },
    {
      "id": 7,
      "name": "Airpods",
      "price": 1200,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/71zny7BTRlL._AC_UF894,1000_QL80_.jpg"
    },
    {
      "id": 8,
      "name": "Nintendo Switch",
      "price": 0,
      "in-stock": false,
      "photo":
          "https://m.media-amazon.com/images/I/71QMz4m-yJL._AC_UF894,1000_QL80_.jpg"
    },
    {
      "id": 9,
      "name": "Ipad Mini 5",
      "price": 36000,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/71S4iO-4B1L._AC_UF894,1000_QL80_.jpg"
    },
    {
      "id": 10,
      "name": "Playstation 5",
      "price": 54000,
      "in-stock": true,
      "photo":
          "https://m.media-amazon.com/images/I/615iJqjOd3L._AC_UF894,1000_QL80_.jpg"
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
        title: Text(AppLocalizations.of(context).getTranslate("products")),
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
              onPressed: () => GoRouter.of(context).push("/products"),
              icon: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return SizedBox.expand(
              child: ListView.builder(
            itemCount: (products.length / 2).ceil(),
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = index * 2; i < (index * 2) + 2; i++)
                  if (i < products.length)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorScheme.secondary.withAlpha(50),
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: const EdgeInsets.all(14.0),
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Image.network(products[i]["photo"].toString()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  products[i]["name"].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.orange,
                                  ),
                                ),
                                if (productsCubit
                                    .isFavorite(products[i]["id"] as int))
                                  IconButton(
                                    onPressed: () {
                                      productsCubit.removeFromFavorites(
                                          products[i]["id"] as int);
                                    },
                                    icon: const Icon(Icons.favorite,
                                        color: Colors.red),
                                  )
                                else
                                  IconButton(
                                    onPressed: () {
                                      productsCubit.addToFavorites(products[i]);
                                    },
                                    icon: const Icon(Icons.favorite_border),
                                  ),
                              ],
                            ),
                            if (products[i]["in-stock"] as bool)
                              ElevatedButton(
                                onPressed: () {
                                  cartCubit.sepeteEkle(
                                    id: products[i]["id"] as int,
                                    photo: products[i]["name"].toString(),
                                    ad: products[i]["name"].toString(),
                                    sayi: 1,
                                    fiyat: products[i]["price"] as double,
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        AppLocalizations.of(context)
                                            .getTranslate("cart"),
                                      ),
                                      content: Text(
                                        AppLocalizations.of(context)
                                            .getTranslate("add-to-cart"),
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
                                              child: Text(AppLocalizations.of(
                                                      context)
                                                  .getTranslate("go-to-cart")),
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
                                ),
                              ),
                            if (products[i]["in-stock"] as bool)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.check_box),
                                      Text(AppLocalizations.of(context)
                                          .getTranslate("in-stock")),
                                    ],
                                  ),
                                  Text(products[i]["price"].toString() + " ₺"),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  const Icon(Icons.error),
                                  Text(
                                    AppLocalizations.of(context)
                                        .getTranslate("not-availible"),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ));
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
              onPressed: () => GoRouter.of(context).push("/shopping"),
              icon: Icon(Icons.shopping_cart),
            ),
            IconButton(
              onPressed: () {
                // İşlemler buraya eklenecek
              },
              icon: Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
    );
  }
}
