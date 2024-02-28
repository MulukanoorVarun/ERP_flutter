import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ColorConstant.dart';
import 'Constants.dart';
import 'FontConstant.dart';
import 'package:crypto/crypto.dart';

// PhonepeRequestObject(type, transactionId, userId, amount, callbackurl, mobile,
//     intrumentType, targetApp, redirectMode, redirectUrl) {
//   PhonepeRequestModel object = PhonepeRequestModel();
//   object.merchantId = PhonePeMerchantId;
//   object.merchantTransactionId = transactionId;
//   object.merchantUserId = userId;
//   object.amount = amount;
//   object.callbackUrl = callbackurl;
//   object.mobileNumber = mobile;
//   if (type == "IOS") {
//     object.deviceContext = DeviceContext(
//         deviceOS: type, merchantCallBackScheme: "iOSIntentIntegration");
//   } else if (type == "ANDROID") {
//     object.deviceContext =
//         DeviceContext(deviceOS: type, merchantCallBackScheme: "");
//   }
//   if (intrumentType == "NET_BANKING") {
//     object.redirectMode = redirectMode;
//     object.redirectUrl = redirectUrl;
//     object.paymentInstrument = PaymentInstrument(
//         type: intrumentType,
//         targetApp: "",
//         bankId: targetApp,
//         vpa: "",
//         authMode: "",
//         cardDetails: null,
//         saveCard: false);
//   } else if (intrumentType == "UPI_COLLECT") {
//     object.paymentInstrument = PaymentInstrument(
//         type: intrumentType,
//         targetApp: "",
//         vpa: targetApp,
//         bankId: "",
//         saveCard: false,
//         cardDetails: null,
//         authMode: "");
//   } else {
//     object.paymentInstrument = PaymentInstrument(
//         type: intrumentType,
//         targetApp: targetApp,
//         bankId: "",
//         vpa: "",
//         authMode: "",
//         cardDetails: null,
//         saveCard: false);
//   }
//   return object;
// }

Base64Encode(credentials) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encoded = stringToBase64.encode(credentials.toString());
  return encoded;
}

Base64Decode(credentials) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String decoded = stringToBase64.decode(credentials);
  return decoded;
}

sha256Encode(credentials) {
  var bytes1 = utf8.encode(credentials); // data being hashed
  var hashedcode = sha256.convert(bytes1);
  return hashedcode;
}

AppBar appBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: ColorConstant.erp_appColor,
    elevation: 0,
    title: Container(
        child: Row(
      children: [
        // Spacer(),
        Container(
          child: InkWell(
            onTap: () => Navigator.pop(context, true),
            child: Text(title,
                textAlign: TextAlign.left,
                style: GoogleFonts.ubuntu(
                  color: ColorConstant.white,
                  fontSize: FontConstant.Size18,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        const Spacer(),
        Container(
          child: const SizedBox(
            width: 40,
            height: 40,
          ),
        ),
      ],
    )),
    titleSpacing: 0,
    leading: Container(
      margin: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () => Navigator.pop(context, true),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 24.0,
        ),
      ),
    ),
  );
}

// AppBar appBar2(BuildContext context, String title) {
//   return AppBar(
//     backgroundColor: Colors.white,
//     elevation: 0,
//     title: Container(
//         child: Row(
//       children: [
//         const Spacer(),
//         Container(
//           child: InkWell(
//             onTap: () => Navigator.pop(context, true),
//             child: Text(title,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.ubuntu(
//                   color: ColorConstant.accent_color,
//                   fontSize: FontConstant.Size18,
//                   fontWeight: FontWeight.w500,
//                 )),
//           ),
//         ),
//         const Spacer(),
//         Container(
//           child: IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const SearchScreen(),
//                   ));
//             },
//             icon: const Icon(
//               Icons.search_rounded,
//               size: 30,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     )),
//     titleSpacing: 0,
//     leading: Container(
//       margin: const EdgeInsets.only(left: 10),
//       child: GestureDetector(
//         onTap: () => Navigator.pop(context, true),
//         child: const Icon(
//           Icons.arrow_back_ios,
//           color: Colors.black,
//           size: 24.0,
//         ),
//       ),
//     ),
//   );
// }

// AppBar StoreLocaterBar(BuildContext context, String title){
//   return AppBar(
//     toolbarHeight: 120,
//     backgroundColor: ColorConstant.accent_color,
//     elevation: 0,
//     title:  Container(
//       child: Text(title,
//           textAlign: TextAlign.center,
//           style:  GoogleFonts.ubuntu(
//             color: ColorConstant.black,
//             fontSize: FontConstant.Size18,
//             fontWeight: FontWeight.w500,
//           )),
//     ),
//     titleSpacing: 0,
//     leading: Container(
//       margin: EdgeInsets.only(left: 10),
//       child: GestureDetector(
//         onTap: () => Navigator.pop(context,true),
//         child: const Icon(
//           Icons.arrow_back_ios,
//           color: Colors.black,
//           size: 24.0,
//         ),
//       ),
//     ),
//
//     child:Container(
//       decoration: BoxDecoration(
//           color: ColorConstant.scafcolor,
//           borderRadius: BorderRadius.circular(10)),
//       child: TextField(
//         cursorColor: Colors.black,
//
//         scrollPadding: EdgeInsets.only(top: 5),
//         // controller: _searchController,
//         enabled: false,
//         onChanged: (value) {
//
//         },
//         decoration: InputDecoration(
//             hintText: 'Search any product for peak performance and vitality.',
//             hintStyle: GoogleFonts.ubuntu(
//                 letterSpacing: 0,
//                 textStyle: TextStyle(
//                     fontSize: FontConstant.Size12,
//                     fontWeight: FontWeight.normal,
//                     overflow: TextOverflow.ellipsis),
//                 color: Colors.grey),
//
//             contentPadding:
//             EdgeInsets.only(left: 5, right: 5, top: 14),
//             suffixIcon: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 Icons.search_rounded,size: 30,
//                 color: Colors.black,
//               ),
//             ),
//             disabledBorder: InputBorder.none
//           // enabledBorder: InputBorder.none,
//           // focusedBorder: InputBorder.none,
//         ),
//       ),
//     ),
//
//   );
// }

// AppBar StoreLocaterBar(BuildContext context, String title) {
//   return AppBar(
//     toolbarHeight: 120,
//     backgroundColor: ColorConstant.accent_color,
//     elevation: 0,
//     leading: Container(
//       margin: EdgeInsets.only(left: 10),
//       child: GestureDetector(
//         onTap: () => Navigator.pop(context, true),
//         child: const Icon(
//           Icons.arrow_back_ios,
//           color: Colors.black,
//           size: 24.0,
//         ),
//       ),
//     ),
//     title: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Container(
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.ubuntu(
//               color: ColorConstant.black,
//               fontSize: FontConstant.Size18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         SizedBox(height: 8),  // Adjust the spacing between title and search bar
//         Container(
//           decoration: BoxDecoration(
//             color: ColorConstant.scafcolor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: TextField(
//             cursorColor: Colors.black,
//             scrollPadding: EdgeInsets.only(top: 5),
//             enabled: false,
//             onChanged: (value) {},
//             decoration: InputDecoration(
//               hintText: 'Search any product for peak performance and vitality.',
//               hintStyle: GoogleFonts.ubuntu(
//                 letterSpacing: 0,
//                 textStyle: TextStyle(
//                   fontSize: FontConstant.Size12,
//                   fontWeight: FontWeight.normal,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 color: Colors.grey,
//               ),
//               contentPadding: EdgeInsets.only(left: 5, right: 5, top: 14),
//               suffixIcon: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.search_rounded,
//                   size: 30,
//                   color: Colors.black,
//                 ),
//               ),
//               disabledBorder: InputBorder.none,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

AppBar StoreLocaterBar(BuildContext context, String title) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: ColorConstant.accent_color,
    elevation: 0,
    title: Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context, true),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 22.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.ubuntu(
                      color: ColorConstant.black,
                      fontSize: FontConstant.Size18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 35,
        ),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => SearchScreen(),
        //         ));
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: ColorConstant.scafcolor,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: TextField(
        //       cursorColor: Colors.black,
        //       scrollPadding: EdgeInsets.only(top: 5),
        //       enabled: false,
        //       onChanged: (value) {},
        //       decoration: InputDecoration(
        //         hintText:
        //             'Search any product for peak performance and vitality.',
        //         hintStyle: GoogleFonts.ubuntu(
        //           letterSpacing: 0,
        //           textStyle: TextStyle(
        //             fontSize: FontConstant.Size12,
        //             fontWeight: FontWeight.normal,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //           color: Colors.grey,
        //         ),
        //         contentPadding: EdgeInsets.only(left: 5, right: 5, top: 10),
        //         suffixIcon: IconButton(
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           icon: Icon(
        //             Icons.search_rounded,
        //             size: 30,
        //             color: Colors.black,
        //           ),
        //         ),
        //         disabledBorder: InputBorder.none,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}

Loaders() {
  return Container(
    color: ColorConstant.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   height: 70,
        //   child: Text("nutsby",style: GoogleFonts.ubuntu(
        //       textStyle: TextStyle(
        //           decorationThickness: 0,
        //           fontSize: FontConstant.Size60,
        //           fontWeight: FontWeight.bold ),
        //       color: ColorConstant.DarkOrange),),
        // ),

        const SpinKitSpinningLines(
          color: Colors.orange,
          // duration: Duration(seconds: 2),
          size: 50,
          lineWidth: 2,
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 200,
          child: Text(
            " “You don't have to be good at it, you just have to do it.”",
            style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                    decorationThickness: 0,
                    fontSize: FontConstant.Size15,
                    fontWeight: FontWeight.normal),
                color: ColorConstant.black.withOpacity(0.4)),
          ),
        ),

        // SvgPicture.asset("/assets/images/NutsLoader.gif")
      ],
    ),
  );
  // NutsLoader.gif
}

// BottomCartBar(context, count, price, loader) {
//   return (count < 1)
//       ? Container()
//       : Container(
//           height: 55,
//           margin: const EdgeInsets.only(left: 10, bottom: 2, right: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: ColorConstant.Dikazo,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(
//                   left: 15,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '$count Items',
//                       style: GoogleFonts.ubuntu(
//                           fontSize: FontConstant.Size12,
//                           fontWeight: FontWeight.w400,
//                           color: ColorConstant.black),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       '$price',
//                       style: GoogleFonts.ubuntu(
//                           fontSize: FontConstant.Size22,
//                           fontWeight: FontWeight.w700),
//                     )
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               Container(
//                 margin: const EdgeInsets.only(
//                   right: 0,
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => const CartScreen()));
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Image.asset(
//                         'assets/images/cart.png',
//                         width: 15,
//                         fit: BoxFit.fill,
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         'View Cart',
//                         style: GoogleFonts.ubuntu(
//                           fontWeight: FontWeight.w400,
//                           fontSize: FontConstant.Size15,
//                         ),
//                       ),
//                       // SizedBox(width: 6,),
//                       // SvgPicture.asset('assets/images/chevron.svg',
//                       //   color: Colors.black,
//                       //   width: FontConstant.Size12,
//                       // )
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               const Text("|"),
//               const SizedBox(
//                 width: 5,
//               ),
//               InkWell(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.clear_sharp,
//                       size: 18,
//                     ),
//                     Text(
//                       "clear",
//                       style: GoogleFonts.ubuntu(
//                           textStyle: TextStyle(
//                               fontSize: FontConstant.Size10,
//                               fontWeight: FontWeight.bold,
//                               overflow: TextOverflow.ellipsis),
//                           color: Colors.black),
//                     )
//                   ],
//                 ),
//                 onTap: () {
//                   toast(context, "Deleting all cart");
//                 },
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//             ],
//           ),
//         );
// }

ProductCard(context) {
  return Card(
    elevation: 3,
    shadowColor: Colors.white,
    margin: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      //set border radius more than 50% of height and width to make circle
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ProductDetails(),
              //     ));
            },
            child: SizedBox(
              height: 130,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/nuts.png",
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          height: 35,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.75),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(11)),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(
                                "assets/images/couponb.svg",
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "50% Off",
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: FontConstant.Size15),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                            //set border radius more than 50% of height and width to make circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(
                              "assets/images/Heart.svg",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            SizedBox(
              width: 120,
              child: Text(
                "Berries And Nuts",
                style: GoogleFonts.ubuntu(
                    fontSize: FontConstant.Size12, fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              "1 Kg",
              style: GoogleFonts.ubuntu(
                  fontSize: FontConstant.Size10,
                  color: Colors.orange,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  "970",
                  style: GoogleFonts.ubuntu(
                      fontSize: FontConstant.Size15,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
                Text(
                  " 970",
                  style: GoogleFonts.ubuntu(
                    fontSize: FontConstant.Size18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                InkWell(
                  child: Container(
                    height: 30,
                    // padding:,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstant.buttonback),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Add",
                          style: GoogleFonts.ubuntu(
                              fontSize: FontConstant.Size10,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 15,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.orangeAccent,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ],
    ),
  );
}

//
// CategoryProductCard(context, favfun, cartfun, cartdec, ProductList data) {
//   double screenWidth = MediaQuery.of(context).size.width;
//   return Card(
//     elevation: 3,
//     shadowColor: Colors.white,
//     margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 16.0),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//       //set border radius more than 50% of height and width to make circle
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ProductDetails(prod_id:data.productId!),
//                   ));
//             },
//             child: Container(
//               height: 115,
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(
//                               "${data.image}",
//                             ),
//                             fit: BoxFit.cover),
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Positioned(
//                         left: 0,
//                         top: 0,
//                         child: Container(
//                           height: 35,
//                           width: 80,
//                           decoration: BoxDecoration(
//                             color: Colors.green.withOpacity(0.75),
//                             borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(10),
//                                 topLeft: Radius.circular(11)),
//                           ),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               SvgPicture.asset(
//                                 "assets/images/couponb.svg",
//                               ),
//                               SizedBox(width: 3),
//                               Text(
//                                 "50% Off",
//                                 style: GoogleFonts.ubuntu(
//                                     color: Colors.white, fontSize: FontConstant.Size15),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                       InkWell(
//                         onTap: () {
//                           favfun(data.productId);
//                         },
//                         child: Container(
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(80),
//                               //set border radius more than 50% of height and width to make circle
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Icon(Icons.favorite_border_outlined,color: Colors.orange,)
//                               // SvgPicture.asset(
//                               //   "assets/images/Heart.svg",
//                               // ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Row(
//           children: [
//             SizedBox(width: 10),
//             Container(
//               width: screenWidth * 0.32,
//               child: Text(
//                 "${data.name}",
//                 style: GoogleFonts.ubuntu(fontSize: FontConstant.Size12,fontWeight: FontWeight.w400),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 2,
//         ),
//         Row(
//           children: [
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               "${data.weightG} Kg",
//               style: GoogleFonts.ubuntu(
//                   fontSize: FontConstant.Size10,
//                   color: Colors.orange,
//                   fontWeight: FontWeight.normal),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Row(
//           children: [
//             SizedBox(
//               width: 10,
//             ),
//             Column(
//               children: [
//                 Text(
//                   "₹${data.mrp}",
//                   style: GoogleFonts.ubuntu(
//                     fontSize: FontConstant.Size15,
//                       decoration: TextDecoration.lineThrough,
//                       color: Colors.grey),
//                 ),
//                 Text(
//                   "₹${data.price}",
//                   style: GoogleFonts.ubuntu(
//                     fontSize: FontConstant.Size18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             Spacer(),
//             if(int.parse(data.cartQuantity!)>0) ...[
//                 quantityWidget(data.cartQuantity,data,cartfun),
//             ] else ...[
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     cartfun(data,"+");
//                   },
//                   child: Container(
//                     height: 30,
//                     // padding:,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: ColorConstant.buttonback),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           "Add",
//                           style: GoogleFonts.ubuntu(
//                            fontSize: FontConstant.Size10,
//                               color: Colors.orangeAccent,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         CircleAvatar(
//                             backgroundColor: Colors.white,
//                             radius: 15,
//                             child: Icon(
//                               Icons.add,
//                               size: 20,
//                               color: Colors.orangeAccent,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             ],
//             SizedBox(
//               width: 5,
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }
//
quantityWidget(quantity, productObj, function) {
  // Size size = MediaQuery.of(context).size;
  return Container(
    height: 30,
    decoration: BoxDecoration(
      color: Colors.orange.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 2,
        ),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.white,
            child: Center(
                child: IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.remove),
              padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
              color: Colors.orange,
              onPressed: () {
                function(productObj, "-");
                // quantity = (int.parse(quantity) - 1).toString();
                // add_to_cart_fun(list_now_here[index].id, quantity);
                // setState(() => list_now_here[index].cartQuantity = quantity);
                // list_now_here[index].cartQuantity = quantity;
              },
            )),
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Text("$quantity",
            style:
                const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        const SizedBox(
          width: 3,
        ),
        Container(
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.white,
            child: Center(
                child: IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.add),
              padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
              color: Colors.orange,
              onPressed: () {
                function(productObj, "+");
                // quantity = (int.parse(quantity) + 1).toString();
                //
                // add_to_cart_fun(list_now_here[index].id, quantity);
                // setState(() => list_now_here[index].cartQuantity = quantity);
                // list_now_here[index].cartQuantity = quantity;
              },
            )),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
      ],
    ),
  );
}

quantityWidget1(quantity, productObj, function) {
  // Size size = MediaQuery.of(context).size;
  return Container(
    width: 165,
    height: 30,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.orange.shade100),
      color: Colors.orange.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.white,
            // decoration: BoxDecoration(
            //
            //     borderRadius: BorderRadius.circular(5),
            //     color: Colors.white,
            // ),
            child: Center(
                child: IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.remove),
              padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
              color: Colors.orange,
              onPressed: () {
                function(productObj, "-");
                // quantity = (int.parse(quantity) - 1).toString();
                // add_to_cart_fun(list_now_here[index].id, quantity);
                // setState(() => list_now_here[index].cartQuantity = quantity);
                // list_now_here[index].cartQuantity = quantity;
              },
            )),
          ),
        ),
        const Spacer(),
        Text("$quantity",
            style:
                const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        const Spacer(),
        Container(
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.white,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(5),
            //   // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0),topRight:Radius.circular(5.0)),
            //   color: Colors.white,
            // ),
            child: Center(
                child: IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.add),
              padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
              color: Colors.orange,
              onPressed: () {
                function(productObj, "+");
                // quantity = (int.parse(quantity) + 1).toString();
                //
                // add_to_cart_fun(list_now_here[index].id, quantity);
                // setState(() => list_now_here[index].cartQuantity = quantity);
                // list_now_here[index].cartQuantity = quantity;
              },
            )),
          ),
        ),
      ],
    ),
  );
}

quantityWidget_loader() {
  // Size size = MediaQuery.of(context).size;
  return Container(
    width: 165,
    height: 30,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(),
        SpinKitRing(
          color: Colors.orange,
          // duration: Duration(seconds: 2),
          size: 20,
          lineWidth: 2,
        ),
        Spacer(),
      ],
    ),
  );
}

loading_image(image,type){

  return CachedNetworkImage(
    filterQuality: FilterQuality.none,
    imageUrl: "${image}",fadeOutCurve: Curves.bounceOut,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: imageProvider,
          filterQuality: FilterQuality.low,

          fit: type, ),
      ),
    ),
    placeholder: (context, url) => Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitSpinningLines(color: Colors.orangeAccent,size: 25),
        Text("Loading",style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.normal),
            color: Colors.black),)
      ],
    ),),
    errorWidget: (context, url, error) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline_outlined),
        Text("Unable to load")
      ],
    ),
  );
}

loading_image2(image,type){

  return CachedNetworkImage(
    filterQuality: FilterQuality.none,
    imageUrl: "${image}",fadeOutCurve: Curves.bounceOut,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(

        image: DecorationImage(
          image: imageProvider,
          filterQuality: FilterQuality.low,

          fit: type, ),
      ),
    ),
    placeholder: (context, url) => Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitSpinningLines(color: Colors.orangeAccent,size: 10),
        // Text("Loading",style: GoogleFonts.ubuntu(
        //     textStyle: TextStyle(
        //         fontSize: 5.0,
        //         fontWeight: FontWeight.normal),
        //     color: Colors.black),)
      ],
    ),),
    errorWidget: (context, url, error) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline_outlined),
        Text("Unable to load")
      ],
    ),
  );
}


quantityWidget_loader_pl() {
  // Size size = MediaQuery.of(context).size;
  return Container(
    width: 135,
    height: 30,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(),
        SpinKitRing(
          color: Colors.orange,
          // duration: Duration(seconds: 2),
          size: 20,
          lineWidth: 2,
        ),
        Spacer(),
      ],
    ),
  );
}

quantityWidget_loader2() {
  // Size size = MediaQuery.of(context).size;
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.all(5.0),
    width: 65,
    height: 30,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(),
        SpinKitRing(
          color: Colors.orange,
          // duration: Duration(seconds: 2),
          size: 20,
          lineWidth: 2,
        ),
        Spacer(),
      ],
    ),
  );
}

quantityWidget12(quantity, productObj, function) {
  // Size size = MediaQuery.of(context).size;
  return Container(
    width: 140,
    height: 30,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.orange.shade100),
      color: Colors.orange.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.white,
            // decoration: BoxDecoration(
            //
            //     borderRadius: BorderRadius.circular(5),
            //     color: Colors.white,
            // ),
            child: Center(
                child: IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.remove),
              padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
              color: Colors.orange,
              onPressed: () {
                function(productObj, "-");
                // quantity = (int.parse(quantity) - 1).toString();
                // add_to_cart_fun(list_now_here[index].id, quantity);
                // setState(() => list_now_here[index].cartQuantity = quantity);
                // list_now_here[index].cartQuantity = quantity;
              },
            )),
          ),
        ),
        const Spacer(),
        Text("$quantity",
            style:
                const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        const Spacer(),
        Container(
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.white,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(5),
            //   // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0),topRight:Radius.circular(5.0)),
            //   color: Colors.white,
            // ),
            child: Center(
                child: IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.add),
              padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
              color: Colors.orange,
              onPressed: () {
                function(productObj, "+");
                // quantity = (int.parse(quantity) + 1).toString();
                //
                // add_to_cart_fun(list_now_here[index].id, quantity);
                // setState(() => list_now_here[index].cartQuantity = quantity);
                // list_now_here[index].cartQuantity = quantity;
              },
            )),
          ),
        ),
      ],
    ),
  );
}

RatingStars(rate, size) {
  final children = <Widget>[];
  // Display filled stars for the integer part of the rating
  for (int i = 0; i < double.parse(rate?? "0.0").toInt(); i++) {
    children.add(Icon(
  Icons.star_outlined,
  size: size,
  color: Colors.orangeAccent,
  ));
  }
  // Display a half-filled star if there is a fractional part
  if (double.parse(rate?? "0.0") % 1 != 0) {
    children.add(Icon(
  Icons.star_half,
  size: size,
  color: Colors.orangeAccent,
  ));
  }


  // Ensure that exactly 5 stars are displayed in total
  for (int i = 0; i < 5 - double.parse(rate ?? "0.0").ceil(); i++) {
    children.add(Icon(
  Icons.star_outline,
  size: size,
  color: Colors.orangeAccent,
  ));
  }
  // if(rate!="0")
  // {
  //   children.add(Text("("+rate+")",style: TextStyle(fontSize: subtextSize),));
  //
  // }
  return Row(
    children: children,
  );
}
// ProductDetailsQuantityWidget(quantity,product_obj,function) {
//   // Size size = MediaQuery.of(context).size;
//   return Container(
//     height: 30,
//     decoration: BoxDecoration(
//       color: Colors.orange.withOpacity(0.1),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: 2,
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: CircleAvatar(
//             radius: 12,
//             backgroundColor: Colors.white,
//             child: Center(
//                 child: IconButton(
//                   icon: Icon(Icons.remove),
//                   padding: EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
//                   color: Colors.orange,
//                   onPressed: () {
//                     function("-");
//                     // quantity = (int.parse(quantity) - 1).toString();
//                     // add_to_cart_fun(list_now_here[index].id, quantity);
//                     // setState(() => list_now_here[index].cartQuantity = quantity);
//                     // list_now_here[index].cartQuantity = quantity;
//                   },
//                 )),
//           ),
//         ),
//         SizedBox(
//           width: 3,
//         ),
//         Text("${quantity}", style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold)),
//         SizedBox(
//           width: 3,
//         ),
//         Container(
//           child: CircleAvatar(
//             radius: 12,
//             backgroundColor: Colors.white,
//             child: Center(
//                 child: IconButton(
//                   icon: Icon(Icons.add),
//                   padding: EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
//                   color: Colors.orange,
//                   onPressed: () {
//                     function("+");
//                     // quantity = (int.parse(quantity) + 1).toString();
//                     //
//                     // add_to_cart_fun(list_now_here[index].id, quantity);
//                     // setState(() => list_now_here[index].cartQuantity = quantity);
//                     // list_now_here[index].cartQuantity = quantity;
//                   },
//                 )),
//           ),
//         ),SizedBox(
//           width: 2,
//         ),
//       ],
//     ),
//   );
// }




