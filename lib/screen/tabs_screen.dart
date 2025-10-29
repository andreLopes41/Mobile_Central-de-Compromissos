import 'package:flutter/material.dart';
import '../model/compromisso.dart';
import 'add_compromisso_screen.dart';
import 'home_screen.dart';
import 'calendario_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int _currentIndex = 0;

  late List<Widget> _pages;

  List<Compromisso> compromissos = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(
        compromissos: compromissos,
        onReorder: reordenarCompromisso,
      ),
      AddCompromissoScreen(onSalvar: adicionarCompromisso),
      CalendarioScreen(compromissos: compromissos),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void adicionarCompromisso(Compromisso novo) {
    setState(() {
      compromissos.add(novo);
      compromissos.sort((a, b) => a.dataHora.compareTo(b.dataHora));

      _pages = [
        HomeScreen(
          compromissos: compromissos,
          onReorder: reordenarCompromisso,
        ),
        AddCompromissoScreen(onSalvar: adicionarCompromisso),
        CalendarioScreen(compromissos: compromissos),
      ];

      _currentIndex = 0;
    });
  }

  void reordenarCompromisso(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Compromisso item = compromissos.removeAt(oldIndex);
      compromissos.insert(newIndex, item);

      _pages[0] = HomeScreen(
        compromissos: compromissos,
        onReorder: reordenarCompromisso,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        _currentIndex == 0
            ? 'Compromissos (${compromissos.length})'
            : _currentIndex == 1
                ? 'Adicionar Compromisso'
                : 'Calendário',
      ),
        backgroundColor: const Color(0xFF81C784),
      ),
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600], 
        type: BottomNavigationBarType
            .fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Compromissos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Adicionar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calendário",
          ),
        ],
      ),
    );
  }
}

