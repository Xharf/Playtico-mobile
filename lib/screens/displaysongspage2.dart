import 'package:flutter/material.dart';
import 'package:playticoapp/models/songs_model2.dart';
import 'package:playticoapp/services/songs_data_store.dart';

class DisplaySongs extends StatefulWidget {
  const DisplaySongs({Key? key}) : super(key: key);

  @override
  _DisplaySongsState createState() => _DisplaySongsState();
}

class _DisplaySongsState extends State<DisplaySongs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Songs"),
      ),
      body: _buildSongsPageBody(),
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
            Data songsModel =
            Data.fromJson(snapshot.data);
            return _buildSuccessSection(songsModel);
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
  Widget _buildSuccessSection(Data data) {
    return ListView.builder(
      itemCount: data.songs?.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: _buildItemCountries("${data.songs?[index].title} by ${data.songs?[index].performer}"),
            )
        );
      },
    );
  }
  Widget _buildItemCountries(String value) {
    return Text(value);
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }
}
