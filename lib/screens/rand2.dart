import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:playticoapp/models/songs_model2.dart';
import 'package:playticoapp/screens/loginpage.dart';
import 'package:playticoapp/services/songs_data_store.dart';

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
        backgroundColor: const Color(0xFF960E96),
        title: const Text(
            "Discover",
            style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w800
            )
        ),
      ),
      body: _buildSongsPageBody(),
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

  Widget _buildSongsPageBody() {
    return Container(
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
            return _buildSuccessSection(songsModel.data);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  //Data --> model yang sebenarnya
  Widget _buildSuccessSection(data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Songs List",
                style: TextStyle(
                  color: Color(0xFFB226B2),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: double.infinity, //cara buat dinamis belum tahu
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: data.songs?.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                return SizedBox(
                  width: 250,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    color: Colors.amber,
                    child: Container(
                      height: 100,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Expanded(
                                child:Image.network(data?.songs?[index].cover),
                                flex:2 ,
                              ),
                            ),
                          ),
                          Expanded(
                            child:Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: ListTile(
                                      title: Text("${data?.songs?[index].title}"),
                                      subtitle: Text("${data?.songs?[index].performer}"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child:Text("PLAY"),
                                          onPressed: ()
                                          {},
                                        ),
                                        SizedBox(width: 8,),
                                        TextButton(
                                          child:Text("ADD TO QUEUE"),
                                          onPressed: ()
                                          {},
                                        ),
                                        // IconButton(
                                        //   icon: Icon(Icons.home),//sesuaikan icon
                                        //   //label: 'Home',
                                        //   onPressed: (){},
                                        // ),
                                        SizedBox(width: 8,)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            flex:8 ,
                          ),
                        ],
                      ),
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
          // const SizedBox(
          //   height: 20,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 15),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: Text("Playlist lists",
          //       style: TextStyle(
          //         color: Color(0xFFB226B2),
          //         fontSize: 20,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 127,
          //   child: ListView.separated(
          //     physics: const BouncingScrollPhysics(
          //         parent: AlwaysScrollableScrollPhysics()),
          //     itemCount: 10,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index){
          //       return SizedBox(
          //         width: 127,
          //         child: Card(
          //           color: Colors.amber,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(20)
          //           ),
          //           child: Center(
          //             child: Text('$index'),
          //           ),
          //         ),
          //       );
          //     },
          //     separatorBuilder: (context, index){
          //       return const SizedBox(
          //         width: 17,
          //       );
          //     },
          //   ),
          //),
        ],
      ),
    );
  }

  Widget _buildItemSongs(String value) {
    return Text(value);
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }
}
