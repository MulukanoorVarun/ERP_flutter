//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//  
// import 'package:nutsby/Utils/Helpers.dart';
//
// import '../mytheme.dart';
// class Contactt extends StatefulWidget {
//   const Contactt({Key? key}) : super(key: key);
//
//   @override
//   State<Contactt> createState() => _ContacttState();
// }
// class _ContacttState extends State<Contactt> {
//   bool valuefirst = false;
//   bool valuesecond = false;
//   bool valuethree = false;
//   bool valuefour = false;
//   var requestParameter = {
//
//   };
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Helpers().appBar(context, "Contact"),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//                 children: [
//                   ...List<Container>.generate(1, (index) => addressListItemView1()),
//                   ...List<Container>.generate(1, (index) => addressListItemView2()),
//                   ...List<Container>.generate(1, (index) => addressListItemView3()),
//                   ...List<Container>.generate(1, (index) => addressListItemview4()),
//                   SizedBox(height: 10,),
//                   GestureDetector(
//                       onTap: () {
//                         debugPrint("Clicked On Add Address Button");
//                       },
//                       child: addAddressView())
//                 ] ),
//           ),
//         ),
//       ),
//     );
//   }
//   Container addressListItemView1() {
//     return Container(
//       padding:
//       const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 0,right: 10),
//       margin: const EdgeInsets.only(bottom: 10.0),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//       child: Column(
//         children: [
//           Row(
//               children: [
//                 Container(
//                   height: 27,
//                   width: 7.0,
//                   decoration: BoxDecoration(
//                       color: MyTheme.accent_color,
//                       borderRadius: const BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10.0,
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(top: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "KUMAR",
//                         style: GoogleFonts.ubuntu(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//                       SizedBox(height: 6,),
//                       Text(
//                         "+91 98765 43210",
//                         style: GoogleFonts.ubuntu(
//                             color: Color(0xFF606060),
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   activeColor: MyTheme.accent_color,
//                   value: this.valuefirst,
//                   onChanged: (value) {
//                     setState(() {
//                       this.valuefirst = value!;
//                     });
//                   },
//                 ),
//               ]
//           ),
//         ],
//       ),
//     );
//   }
//
//   Container addressListItemView2() {
//     return Container(
//       padding:
//       const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 0,right: 10),
//       margin: const EdgeInsets.only(bottom: 10.0),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//       child: Column(
//         children: [
//           Row(
//               children: [
//                 Container(
//                   height: 27,
//                   width: 7.0,
//                   decoration: BoxDecoration(
//                       color: MyTheme.accent_color,
//                       borderRadius: const BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10.0,
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(top: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "KUMAR",
//                         style: GoogleFonts.ubuntu(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//                       SizedBox(height: 6,),
//                       Text(
//                         "+91 98765 43210",
//                         style: GoogleFonts.ubuntu(
//                             color: Color(0xFF606060),
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   activeColor: MyTheme.accent_color,
//                   value: this.valuesecond,
//                   onChanged: (value) {
//                     setState(() {
//                       this.valuesecond = value!;
//                     });
//                   },
//                 ),
//               ]
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Container addressListItemView3() {
//     return Container(
//       padding:
//       const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 0,right: 10),
//       margin: const EdgeInsets.only(bottom: 10.0),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//       child: Column(
//         children: [
//           Row(
//               children: [
//                 Container(
//                   height: 27,
//                   width: 7.0,
//                   decoration: BoxDecoration(
//                       color: MyTheme.accent_color,
//                       borderRadius: const BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10.0,
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(top: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "KUMAR",
//                         style: GoogleFonts.ubuntu(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//                       SizedBox(height: 6,),
//                       Text(
//                         "+91 98765 43210",
//                         style: GoogleFonts.ubuntu(
//                             color: Color(0xFF606060),
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   activeColor: MyTheme.accent_color,
//                   value: this.valuethree,
//                   onChanged: (value) {
//                     setState(() {
//                       this.valuethree = value!;
//                     });
//                   },
//                 ),
//               ]
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Container addressListItemview4() {
//     return Container(
//       padding:
//       const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 0,right: 10),
//       margin: const EdgeInsets.only(bottom: 10.0),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//       child: Column(
//         children: [
//           Row(
//               children: [
//                 Container(
//                   height: 27,
//                   width: 7.0,
//                   decoration: BoxDecoration(
//                       color: MyTheme.accent_color,
//                       borderRadius: const BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10.0,
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(top: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "KUMAR",
//                         style: GoogleFonts.ubuntu(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//                       SizedBox(height: 6,),
//                       Text(
//                         "+91 98765 43210",
//                         style: GoogleFonts.ubuntu(
//                             color: Color(0xFF606060),
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   activeColor: MyTheme.accent_color,
//                   value: this.valuefour,
//                   onChanged: (value) {
//                     setState(() {
//                       this.valuefour = value!;
//                     });
//                   },
//                 ),
//               ]
//           ),
//         ],
//       ),
//     );
//   }
//
//   DottedBorder addAddressView() {
//     return DottedBorder(
//       color: Colors.orange,
//       borderType: BorderType.RRect,
//       radius: const Radius.circular(10.0),
//       padding: const EdgeInsets.all(1.0),
//       strokeWidth: 0.5,
//       dashPattern: const [2, 2],
//       child: Container(
//         height: 40,
//         // padding: const EdgeInsets.all(1.0),
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//         alignment: Alignment.center,
//         child: TextButton(
//           onPressed:(){
//             // getContactList();
//           },
//           child:
//           Text(
//             "+ Add New Address",
//             style: TextStyle(
//                 color: Colors.orange, fontSize: 15.0, fontWeight: FontWeight.w500),
//           ),),
//       ),
//     );
//   }
//
//   // getContactList(){
//   //   requestParameter = {
//   //
//   //   };
//   //   serverPostRequest(requestParameter, contactList, true).then((value){
//   //     if(value != null){
//   //       value= contactListFromJson(value);
//   //       if(value.error == 0){
//   //
//   //       }
//   //     }
//   //
//   //   });
//   // }
//
// }
