import 'package:aurora/screens/chatbot_screen.dart';
import 'package:aurora/screens/socialmedia_chat_upload_page.dart';

import '../screens/home_screen.dart';
import '../widgets/side_drawer.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {

  int _pageIndex = 1;
  List<Map<String, Object>> _pages;
  var page2appbar = false;
  var page4appbar = false;

  @override
  void initState() {
    _pages = [
      {},
      {'screen' : HomeScreen(), 'title' : "Aurora",},
      {'screen' : SocialMediaChatUploadPage(page2appbar), 'title' : "Upload Chat",},
      {'screen' : ChatbotScreen(page4appbar), 'title' : "Chatbot",},
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        leading: Builder(
          builder:(ctx) => Ink.image(
            fit: BoxFit.fill,
            image: MediaQuery.of(context).platformBrightness == Brightness.light ? AssetImage('assets/images/menu Icon.png') : AssetImage('assets/images/menu Icon dark.png'),
            child: Container(
              child: InkWell(
                onTap: () => Scaffold.of(ctx).openDrawer(),
                customBorder: CircleBorder(),
              ),
            ),
          )
        ),
        elevation: 0,
        title: Text(
          _pages[_pageIndex]['title'],
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      drawer: SideDrawer(),
      body: _pages[_pageIndex]['screen'],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              blurRadius: 3,
              spreadRadius: 3,
            ),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _pageIndex == 0 ? Icon(Icons.people, size: 40,) : Icon(Icons.people_outline),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _pageIndex == 1 ? Icon(Icons.home, size: 40,) : Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _pageIndex == 2 ? Icon(Icons.add_circle, size: 40,) : Icon(Icons.add_circle_outline),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _pageIndex == 3 ? Icon(Icons.chat, size: 40,) : Icon(Icons.chat),
              label: '',
            )
          ],
          onTap: (index) {
            setState(() {
              _pageIndex = index;
              if (_pageIndex == 2){
                page2appbar = true;
              }
            });
          },
          currentIndex: _pageIndex,
          selectedItemColor: Colors.indigo.shade900,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
      
    );
  }
}