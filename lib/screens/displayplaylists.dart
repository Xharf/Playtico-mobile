import 'package:flutter/material.dart';
import 'package:playticoapp/models/playlists_hive_model.dart';
import 'package:playticoapp/screens/homepage.dart';
import 'package:playticoapp/screens/loginpage.dart';
import 'package:playticoapp/screens/playingnowpage.dart';
import 'package:playticoapp/screens/profilepage.dart';
import 'package:playticoapp/services/songs_data_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playticoapp/models/playlists_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DisplayPlaylists extends StatefulWidget {
  const DisplayPlaylists({Key? key}) : super(key: key);

  @override
  _DisplayPlaylistsState createState() => _DisplayPlaylistsState();
}

int _page = 2;

class _DisplayPlaylistsState extends State<DisplayPlaylists> {
  SharedPreferences? loginData;
  String? token;
  bool? isLogin;

  @override
  void initState(){
    super.initState();
    checkLoginAndInit();
  }

  void checkLoginAndInit() async{

    loginData = await SharedPreferences.getInstance();
    isLogin = ((loginData?.getBool("LoginState") == true) ? true : false);
    token = loginData?.getString("accessToken");
    if (!isLogin!) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
    checkPlaylists();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF960E96),
        title: const Text("All Playlists",
            style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w800)),
      ),
      body: _buildSongsPageBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF960E96),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFFDA77D7),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Color(0xFFDA77D7)),
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
        // onTap: (newIndex) => setState(() => _page = newIndex),
        onTap: (index) {
          switch (index) {
            case 0:
              {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomePage()));
              }
              break;
            case 3:
              {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ProfilePage()));
              }
          }
        },
        currentIndex: _page,
      ),

    );
  }

  Widget _buildSongsPageBody() {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: Hive.box<PlaylistHive>("playlists_hive_model").listenable(),
        builder: (
            BuildContext context,
            Box<PlaylistHive> box, _,
            ) {
          if (box.isNotEmpty) {
              return _buildSuccessSection(box);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  void checkPlaylists() async{
    Box<PlaylistHive> playlistHiveBox = Hive.box<PlaylistHive>("playlists_hive_model");
    if(playlistHiveBox.isEmpty) {
      Map<String, dynamic> response = await SongDataSource.instance
          .loadPlaylists(token!);
      UserPlaylistModel playlistModel = UserPlaylistModel.fromJson(response);
      if (playlistModel.status == "success") {
        for (int i = 0; i < playlistModel.data!.playlists!.length; i++) {
          playlistHiveBox.add(PlaylistHive(
            id: playlistModel.data!.playlists![i].id,
            name: playlistModel.data!.playlists![i].name,
            cover: playlistModel.data!.playlists![i].cover,
            username: playlistModel.data!.playlists![i].username,
          ));
        }
      }
    }
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  //Data --> model yang sebenarnya
  Widget _buildSuccessSection(Box<PlaylistHive> data) {
    return ListView.builder(
      itemCount: data.values.length,
      itemBuilder: (BuildContext context, int index) {
        PlaylistHive? res = data.getAt(index);
        return Card(
          child: InkWell(
            splashColor: Colors.white,
            child: ListTile(
              leading: Image.network(res!.cover!),
              title: Text(res!.name!),
              subtitle: Text("Milik : " + res!.username!),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemSongs(String value) {
    return Text(value);
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }
}
