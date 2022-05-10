import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:playticoapp/screens/loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int _page = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    switch (_page) {
      case 3:
        Future.delayed(Duration.zero, ()async{
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage())
          );
        });
        break;
    }
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        elevation: 0,
        title: const Text(
          "Discover",
          style: TextStyle(
            fontSize: 32,
            color: Color(0xFFB226B2),
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(
                offset: Offset(2.0, 1.0),
                blurRadius: 1.0,
                color: Color(0xFFFF85FF),
              )
            ]
          )
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Song Lists",
                  style: TextStyle(
                    color: Color(0xFFB226B2),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 127,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return SizedBox(
                      width: 127,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        color: Colors.amber,
                        child: Center(
                          child: Text('$index'),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index){
                    return const SizedBox(
                      width: 17,
                    );
                  },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Playlist lists",
                  style: TextStyle(
                    color: Color(0xFFB226B2),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 127,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return SizedBox(
                    width: 127,
                    child: Card(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text('$index'),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index){
                  return const SizedBox(
                    width: 17,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF960E96),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFFDA77D7),
          selectedLabelStyle: const TextStyle(
            color: Colors.white
          ),
          unselectedLabelStyle: const TextStyle(
            color: Color(0xFFDA77D7)
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Playlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (newPage) => setState(() => _page = newPage),
          currentIndex: _page,
        ),
    );
  }
}
