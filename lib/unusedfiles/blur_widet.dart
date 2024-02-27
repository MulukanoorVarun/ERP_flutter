

import 'package:flutter/material.dart';


class BlurWidget extends StatefulWidget {
  const BlurWidget({Key? key}) : super(key: key);

  @override
  State<BlurWidget> createState() => _BlurWidgetState();
}

class _BlurWidgetState extends State<BlurWidget> {
  var requestParameter = {};
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body:
      Column(
        children: [
          TextButton(onPressed: (){
            // getProductDetails();
          }, child:
          const Text('Next')
          )
        ],
      ),

      // Stack(
      //   children: <Widget>[
      //     /*ConstrainedBox(
      //         constraints: const BoxConstraints.expand(),
      //         child: const FlutterLogo()
      //     ),*/
      //     Image.asset(
      //       'assets/images/nuts.png',
      //       height: size.height*.62,
      //       width: size.width,
      //       fit: BoxFit.fitWidth,
      //     ),
      //     Center(
      //       child: ClipRect(
      //         child: BackdropFilter(
      //           filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      //           child: Container(
      //             height: 70,
      //             width: 70,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(25.0),
      //                 color: Colors.grey.shade200.withOpacity(0.5)
      //             ),
      //             child: const Center(
      //               child: Text(
      //                   'Skip',
      //                   style: TextStyle(color: Colors.black)
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  //
  // getProductDetails(){
  //   requestParameter = {
  //     "product_id": "1",
  //   };
  //   serverPostRequest(requestParameter, productDetails, true).then((value) => {
  //     debugPrint('dfg${value}'),
  //     if(value != null){
  //       print('next'),
  //       productDetailsFromJson(value),
  //       debugPrint('fdfhdhf${value}'),
  //       if(value.error == 0){
  //         setState(() {
  //           // isLoading = false;
  //           // productDetailsData = value.Data;
  //           // debugPrint('abcd${value.Data}');
  //           // ProductList = value.subCategoryList;
  //         })
  //       }
  //     } }
  //   );

  // }


// getFavourite(String RequestParameters, String endPoint){
  //   requestParameter = {
  //     "product_id" : "",
  //   };
  //   serverPostRequest(requestParameter, favoriteProduct, true).then((value) =>{
  //     if(value!=null){
  //       value=favouriteFromJson(value),
  //       if(value.error == 0){
  //         setState((){
  //
  //         }),
  //         Helpers().showSnackBar(context,value.message),
  //       }
  //     }
  //   });
  // }
}
