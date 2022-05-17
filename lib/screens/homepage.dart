import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:playticoapp/models/playlists_model.dart';
import 'package:playticoapp/models/refresh_token_model.dart';
import 'package:playticoapp/models/songs_model2.dart';
import 'package:playticoapp/screens/displaysongs.dart';
import 'package:playticoapp/screens/loginpage.dart';
import 'package:playticoapp/screens/playingnowpage.dart';
import 'package:playticoapp/screens/profilepage.dart';
import 'package:playticoapp/services/autentication_data_source.dart';
import 'package:playticoapp/services/songs_data_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int _page = 0;

class _HomePageState extends State<HomePage> {
  SharedPreferences? loginData;
  String? token;
  bool? isLogin;

  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }

  void checkIsLogin() async {
    loginData = await SharedPreferences.getInstance();
    isLogin = ((loginData?.getBool("LoginState") == true) ? true : false);
    token = loginData?.getString("accessToken");
    if (!isLogin!) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // switch (_page) {
    //   case 3:
    //     Future.delayed(Duration.zero, () async {
    //       Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(builder: (context) => const ProfilePage()));
    //     });
    //     break;
    // }
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF960E96),
        title: const Text("Discover",
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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Songs List",
                    style: TextStyle(
                      color: Color(0xFFB226B2),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DisplaySongs()));
                      },
                      child: const Text("See More"))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 127,
            child: FutureBuilder(
              future: SongDataSource.instance.loadSongs(),
              builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                  ) {
                if (snapshot.hasError) {
                  return _buildErrorSection();
                }
                if (snapshot.hasData) {
                  SongsModel songsModel = SongsModel.fromJson(snapshot.data);
                  var data = songsModel.data;
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: data!.songs!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 127,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlayingNow(
                                  songId: data.songs?[index].id,
                                  songUrl: data.songs?[index].song,
                                )));
                          },
                          splashColor: Colors.white,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  child: Text(data.songs![index].title!,
                                    style:TextStyle(
                                      color: Color(0xFFB226B2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          data.songs![index].cover!)),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 17,
                      );
                    },
                  );
                }
                return _buildLoadingSection();
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
              child: Text(
                "Playlist lists",
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
            child: FutureBuilder(
              future: SongDataSource.instance.loadPlaylists(token!),
              builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                  ) {
                if (snapshot.hasError) {
                  return _buildErrorSection();
                }
                if (snapshot.hasData) {
                  UserPlaylistModel playlistModel = UserPlaylistModel.fromJson(snapshot.data);
                  var data = playlistModel.data;
                  if(data!.playlists!.length>0) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: data.playlists!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 127,
                          child: InkWell(
                            onTap: () {},
                            splashColor: Colors.white,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  child: Text(data.playlists![index].name!,
                                    style:TextStyle(
                                      color: Color(0xFFB226B2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                            data.playlists![index].cover!)),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 17,
                        );
                      },
                    );
                  } else {
                    return Text(
                      "Data kosong",
                      style: TextStyle(
                        color: Color(0xFFB226B2),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                }
                return _buildLoadingSection();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


  Widget _buildItemSongs(String value) {
    return Text(value);
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }
}
