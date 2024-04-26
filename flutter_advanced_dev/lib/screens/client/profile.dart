import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ProfileItem(
              avatar: 'assets/images1/eb.jpg',
              name: 'emirhanb16',
            ),
            Divider(),
            MenuItem(icon: Icon(Icons.shop), title: "135 ürün", onTap: () {}),
            Divider(),
            MenuItem(
                icon: Icon(Icons.person), title: "349 takipçi", onTap: () {}),
            Divider(),
            MenuItem(
                icon: Icon(Icons.phone_android),
                title: "En Beğenilen Ürün:Samsung Galaxy S8 Edge",
                onTap: () {}),
            Divider(),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Text("Geri dön"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String avatar;
  final String name;

  const ProfileItem({required this.avatar, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(avatar),
          radius: 50,
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: onTap,
    );
  }
}
