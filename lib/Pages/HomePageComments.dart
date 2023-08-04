
//   Align buildAlign(int index, BuildContext context) {
//     return Align(
//       // baad mei dekhlio center mei kese kre
//       alignment: Alignment.bottomRight,
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             border: Border.all(
//                 width: 10,
//                 color: Colors
//                     .transparent), //color is transparent so that it does not blend with the actual color specified
//             color: const Color.fromRGBO(
//                 0, 0, 0, 0.5) // Specifies the background color and the opacity
//             ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               pdfData[index]['Name'],
//               style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                     color: Colors.white,
//                   ),
//             ),
//             Container(
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () async {
//                       bool isLiked = await checkBool(pdfData[index]['Name']);
//                       if (!isLiked) {
//                         setState(() {
//                           col = Colors.pinkAccent;
//                         });
//                         incrementLikesCount(index);
//                         isLiked = true;
//                         addBoolToSF(pdfData[index]['Name'], isLiked);
//                       }
//                     },
//                     icon: Icon(Icons.favorite),
//                     color: col,
//                   ),
//                   Text(
//                     pdfData[index]['Votes'].toString(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     )
//   }

/* body mei paste krdio agr upr wala na chle to*/
// StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('1').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//
//           var items = snapshot.data!.docs; // List of documents in the collection
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Set the number of grid items in each row
//               crossAxisSpacing: 10.0,
//               mainAxisSpacing: 10.0,
//             ),
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               var item = items[index].data() as Map<String, dynamic>;
//               var itemName = item['Name'];
//               // Return a widget with the item information
//               return GridTile(
//                 child: Column(
//                   children: [
//                     Text(itemName),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//
// FutureBuilder<Widget>(
//   future: likeButton(pdfData[index]['name']),
//   builder: (context, snapshot) {
//       return Container();
//   },
// ),
// likeButton(pdfData[index]['Name'],),
// IconButton(
//   onPressed: () async {
//     bool isLiked =
//         await checkBool(pdfData[index]['Name']);
//     if (!isLiked) {
//       // setState(() {
//       //   col = Colors.pinkAccent;
//       // });
//       incrementLikesCount(index);
//       isLiked = true;
//       addBoolToSF(
//           pdfData[index]['Name'], isLiked);
//     }
//   },
//   icon: Icon(Icons.favorite),
//   color: col,
// ),