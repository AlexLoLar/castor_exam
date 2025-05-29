import 'package:castor_exam/features/libreries/presentation/bloc/library_bloc.dart';
import 'package:castor_exam/features/libreries/presentation/pages/library_page.dart';
import 'package:castor_exam/features/player/presentation/pages/player_page.dart';
import 'package:castor_exam/features/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:castor_exam/features/search/presentation/bloc/search_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    Center(
      child: Text('Bienvenido'),
    ),
    const SearchPage(),
    const LibraryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.read<SearchBloc>().add(SearchQueryChanged(''));
    if (index == 2) {
      LibraryBloc libraryBloc = context.read<LibraryBloc>();
      libraryBloc.add(LoadTracksEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      if (_selectedIndex == 1)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Icon(Icons.search, color: Colors.grey),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    onChanged: (query) {
                                      context
                                          .read<SearchBloc>()
                                          .add(SearchQueryChanged(query));
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Buscar ...',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _pages,
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: AudioPlayerWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Librerías',
          ),
        ],
      ),
    );
  }
}
