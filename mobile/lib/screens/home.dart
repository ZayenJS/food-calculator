import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController calories = TextEditingController();
  TextEditingController proteins = TextEditingController();
  TextEditingController carbohydrates = TextEditingController();
  TextEditingController sugars = TextEditingController();
  TextEditingController fats = TextEditingController();
  TextEditingController saturated = TextEditingController();
  TextEditingController salt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: const Center(
                child: Text(
                  "Food Calculator",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image:
                      const ExactAssetImage("assets/images/drawer-banner.jpg"),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8),
                    BlendMode.dstATop,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, "/add-ingredient"),
              title: const Text("Ajouter un ingrédient",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, "/search-ingredient"),
              title: const Text("Calculer",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leadingWidth: 30,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 6),
              child: const Icon(Icons.restaurant),
            ),
            Text(widget.title),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/search-ingredient"),
            iconSize: 34,
            icon: const Icon(Icons.calculate_rounded),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/add-ingredient'),
            icon: const Icon(Icons.add),
            iconSize: 34,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec lacinia nec dolor in imperdiet. Quisque tristique dignissim tortor, in porta.")
            ],
          ),
        ),
      ),
    );
  }
}
