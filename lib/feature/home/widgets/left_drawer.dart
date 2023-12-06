import 'package:bookshelve_flutter/feature/forum/screens/forum_page.dart';
import 'package:bookshelve_flutter/feature/home/screens/home.dart';
import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // TODO: Bagian drawer header
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Explore',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Explore the fontain of knowledge!",
                  // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                ),
              ],
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.forum_outlined),
            title: const Text('Forum'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              // TODO: Buatlah routing ke ShopFormPage di sini,
              // setelah halaman ShopFormPage sudah dibuat.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForumMainPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded),
            title: const Text('Bookmark'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              // TODO: Buatlah routing ke ShopFormPage di sini,
              // setelah halaman ShopFormPage sudah dibuat.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Event'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              // TODO: Buatlah routing ke ShopFormPage di sini,
              // setelah halaman ShopFormPage sudah dibuat.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.auto_stories_outlined),
            title: const Text('My Books'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              // TODO: Buatlah routing ke ShopFormPage di sini,
              // setelah halaman ShopFormPage sudah dibuat.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
