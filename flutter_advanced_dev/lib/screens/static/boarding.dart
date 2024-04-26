import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../../core/storage.dart';
import '../../widgets/page/boarding_item.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final boardingData = [
    {
      "image":
          "https://static.vecteezy.com/system/resources/thumbnails/001/871/349/small/illustration-of-shopping-and-spending-money-with-e-commerce-apps-own-your-own-shop-with-e-commerce-find-the-right-item-with-online-shops-landing-page-template-for-web-websites-site-banner-flyer-free-vector.jpg",
      "title": "Birinci Sayfa",
      "description":
          "You can order what you want in just seconds using our awesome application",
    },
    {
      "image":
          "https://www.pngkey.com/png/detail/873-8737095_kisspng-information-e-commerce-euclidean-vector-advertisin-business.png",
      "title": "Birinci Sayfa",
      "description":
          "You can order what you want in just seconds using our awesome application",
    },
    {
      "image":
          "https://i.graphicmama.com/blog/wp-content/uploads/2021/06/15141255/Free-Eccomerce-Illustrations-Vector-07.png",
      "title": "Birinci Sayfa",
      "description":
          "You can order what you want in just seconds using our awesome application",
    },
    {
      "image":
          "https://i.graphicmama.com/blog/wp-content/uploads/2021/06/15141255/Free-Eccomerce-Illustrations-Vector-07.png",
      "title": "Birinci Sayfa",
      "description":
          "You can order what you want in just seconds using our awesome application",
    },
    {
      "image":
          "https://i.graphicmama.com/blog/wp-content/uploads/2021/06/15141255/Free-Eccomerce-Illustrations-Vector-07.png",
      "title": "Birinci Sayfa",
      "description":
          "You can order what you want in just seconds using our awesome application",
    },
  ];
  int page = 0;
  final PreloadPageController _pageController = PreloadPageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () async {
                final storage = Storage();
                await storage.firstLaunched();
                GoRouter.of(context).replace("/home");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: page == 2 ? const Text("Home") : const Text("Skip"),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: PreloadPageView.builder(
          controller: _pageController,
          itemCount: boardingData.length,
          preloadPagesCount: boardingData.length,
          onPageChanged: (value) {
            setState(() {
              page = value;
            });
          },
          itemBuilder: (context, index) => BoardingItem(
            image: boardingData[index]["image"]!,
            title: boardingData[index]["title"]!,
            description: boardingData[index]["description"]!,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Align(
          alignment: Alignment.center,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: boardingData.length,
              itemBuilder: (context, index) => Icon(
                    page == index
                        ? CupertinoIcons.circle_filled
                        : CupertinoIcons.circle,
                  )),
        ),
      ),
    );
  }
}
