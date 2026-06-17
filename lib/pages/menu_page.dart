import 'package:flutter/material.dart';

import 'home_page.dart';
import 'api_page.dart';
import 'form_page.dart';
import 'about_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() =>
      _MenuPageState();
}

class _MenuPageState
    extends State<MenuPage> {
  int paginaActual = 0;

  late final List<Widget> paginas;

  @override
  void initState() { super.initState();
      paginas = [
      const HomePage(),
      const ApiPage(),
      const FormPage(),
      const AboutPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[paginaActual],

      bottomNavigationBar:
          NavigationBar(
        selectedIndex:
            paginaActual,
        onDestinationSelected:
            (index) {
          setState(() {
            paginaActual =
                index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon:
                Icon(Icons.home),
            label:
                'Inicio',
          ),
          NavigationDestination(
            icon:
                Icon(Icons.public),
            label:
                'Series',
          ),
          NavigationDestination(
            icon:
                Icon(Icons.add),
            label:
                'Agregar',
          ),
          NavigationDestination(
            icon:
                Icon(Icons.info),
            label:
                'Acerca de',
          ),
        ],
      ),
    );
  }
}