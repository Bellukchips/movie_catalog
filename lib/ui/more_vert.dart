class Morevert {
  static const String Favorite = "Favorite";
  static const String Settings = "Settings";

  static const List<String> more = <String>[Favorite,Settings];
}


// class AcountLogin extends StatefulWidget {
//   @override
//   _AcountLoginState createState() => _AcountLoginState();
// }

// class _AcountLoginState extends State<AcountLogin>
//     with SingleTickerProviderStateMixin {
//   TabController controller;

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller.dispose();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = new TabController(vsync: this, length: 2);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff2d3447),
//       body: Container(
//         child: ListView(
//           shrinkWrap: true,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
//               child: Text(
//                 "Hello ..",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "carter"),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
//               child: Text(
//                 "Welcome to ",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "carter"),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 40, right: 40),
//               child: Text(
//                 "Apps movie catalog",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "carter"),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
//               child: Card(
//                 child: Column(
//                   children: <Widget>[
//                     TabBar(
//                       controller: controller,
//                       tabs: <Widget>[
//                         Tab(
//                             child: Text("LOGIN",
//                                 style: TextStyle(color: Colors.black))),
//                         Tab(
//                             child: Text("REGISTER",
//                                 style: TextStyle(color: Colors.black)))
//                       ],
//                     ),
//                     SizedBox(
//                       width: 300,
//                       height: 230,
//                       child: TabBarView(
//                         controller: controller,
//                         children: <Widget>[
//                           Form(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Column(
//                                 children: <Widget>[
//                                   TextField(
//                                     decoration: InputDecoration(
//                                       labelText: "Email",
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   TextField(
//                                     obscureText: true,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       labelText: "Password",
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 40.0,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       MaterialButton(
//                                         onPressed: () {
//                                           Navigator.of(context).push(MaterialPageRoute(
//                                             builder: (context) => Dashboard()
//                                           ));
//                                         },
//                                         child: Text("data"),
//                                       ),
//                                       MaterialButton(
//                                         onPressed: () {},
//                                         child: Text("data"),
//                                       ),
//                                       MaterialButton(
//                                         onPressed: () {},
//                                         child: Text("data"),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Form(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Column(
//                                 children: <Widget>[
//                                   TextField(
//                                     decoration:
//                                         InputDecoration(labelText: "Nama"),
//                                   ),
//                                   TextField(
//                                     obscureText: true,
//                                     keyboardType: TextInputType.text,
//                                     decoration:
//                                         InputDecoration(labelText: "Email"),
//                                   ),
//                                   TextField(
//                                     keyboardType: TextInputType.number,
//                                     decoration:
//                                         InputDecoration(labelText: "Phone"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
