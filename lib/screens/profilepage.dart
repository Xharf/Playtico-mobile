import 'package:flutter/material.dart';
import 'package:playticoapp/models/user_profile_model.dart';
import 'package:playticoapp/screens/displayplaylists.dart';
import 'package:playticoapp/screens/homepage.dart';
import 'package:playticoapp/screens/loginpage.dart';
import 'package:playticoapp/services/user_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

int _page = 3;

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences? loginData;
  bool? isLogin;
  String? username;

  @override
  void initState(){
    super.initState();
    checkIsLogin();
  }

  void checkIsLogin() async{
    loginData = await SharedPreferences.getInstance();
    isLogin = ((loginData?.getBool("LoginState") == true)? true: false);
    username = loginData?.getString("username");
    if(!isLogin!){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_page) {
      case 0:
        Future.delayed(Duration.zero, () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
        });
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: _buildProfilePageBody(),
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
        onTap: (index) {
          switch (index) {
            case 0:
              {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomePage()));
              }
              break;
            case 2:
              {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DisplayPlaylists()));
              }
              break;
          }
        },
        currentIndex: _page,
      ),
    );
  }

  @override
  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget _buildProfilePageBody(){
    return FutureBuilder(
      future: UserDataSource.instance.get(username),
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        if (snapshot.hasError) {
          return Text("Error has been appeared");
        }
        if (snapshot.hasData) {
          UserProfileModel userProfileModel =
              UserProfileModel.fromJson(snapshot.data);
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.assignment_ind_outlined),
                    Text(
                      userProfileModel.data!.user!.fullname!,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _logoutUser();
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70.0),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    userProfileModel.data!.user!.profilePicture!),
                radius: 70.0,
              ),
              SizedBox(height: 20.0),
              Text(
                userProfileModel.data!.user!.username!,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 20.0),
                  Column(
                    children: [
                      Text(
                        "29",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Following",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "121.9k",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Followers",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "7.5M",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Like",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.0),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Follow",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(140.0, 55.0),
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  OutlinedButton(
                    onPressed: () {},
                    child: Icon(Icons.mail_outline_outlined),
                    style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        fixedSize: Size(50.0, 60.0)),
                  )
                ],
              ),
            ],
          );
        }
        return _buildLoadingSection();
      },
    );
  }
}
