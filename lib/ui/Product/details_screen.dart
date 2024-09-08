// import 'package:flutter/material.dart';
//
// import '../../database/model/add_product.dart';
//
// class ProductDetails extends StatelessWidget {
//
//   AddProductModel addProductModel;
//   ProductDetails({required this.addProductModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'AgriHawk Product Details',
//           style: TextStyle(color: Colors.black.withOpacity(.8)),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Card(
//             elevation: 4.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     ': تفاصيل المنتج',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blueAccent,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: Text(
//                       addProductModel.des?.trim() ?? "",
//                       style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
