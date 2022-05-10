import 'package:flutter/material.dart';
import 'package:playticoapp/models/songs_model.dart';
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
            // Kesalahan sebelumnya ada di proses convertnya
            // struktur response api yang kita punya itu
            // {
            //   "status" : "string",
            //   "data": {
            //     "songs": [
            //        "id": "string"
            //        dll...
            //     ],
            //   }
            // }
            // dia harus diconvert mulai dari struktur teratasnya,
            // bukan cuma data di dalamnya aja. Itu artinya harus ada
            // variable yang nerima status dan data
            // setelah itu data baru bisa digunakan.
            // singkatnya, yang harusnya dipakai itu SongsModel.fromJson
            // bukan Data.fromJson

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
    return ListView.builder(
      itemCount: data.songs?.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: _buildItemCountries(
              "${data?.songs?[index].title} by ${data?.songs?[index].performer}"),
        ));
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
