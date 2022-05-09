// import 'package:flutter/material.dart';
// import 'package:playticoapp/models/songs_model2.dart';
// import 'package:playticoapp/services/songs_data_store.dart';
//
// class DisplaySongs extends StatefulWidget {
//   const DisplaySongs({Key? key}) : super(key: key);
//
//   @override
//   _DisplaySongsState createState() => _DisplaySongsState();
// }
//
// class _DisplaySongsState extends State<DisplaySongs> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("All Songs"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Container(
//               child: Image.network(
//                 imageUrls,
//                 width: 192,
//               ),
//               decoration: BoxDecoration(
//                 border: Border.all(width: 0.5, color: Colors.blueGrey),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
//               child: Column(
//                 children: [
//                   Text(
//                     "${albumName}",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "${singer}",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "${releaseDate}",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       SizedBox(
//                         height: 10,
//                         child: VerticalDivider(
//                           color: Colors.black54,
//                         ),
//                       ),
//                       Text(
//                         "${widget.album.source}",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Card(
//               color: Colors.black12,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 23,
//                       child: Text("#",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 12, color: Colors.white)),
//                     ),
//                     SizedBox(
//                       height: 25,
//                       child: VerticalDivider(
//                         color: Colors.white54,
//                       ),
//                     ),
//                     Text("Title",
//                         style: TextStyle(fontSize: 12, color: Colors.white))
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 23,
//                               child: Text(
//                                 "${index + 1}",
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 25,
//                               child: VerticalDivider(
//                                 color: Colors.black54,
//                               ),
//                             ),
//                             Text(widget.album.songs[index])
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: widget.album.songs.length),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
