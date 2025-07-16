# falcon_aviation

A new Flutter project for  Falcon Aviation

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




// void updateMyprofile() async {
//
//   print(_firstnameTextfield.text);
//   print(_lastnameTextfield.text);
//   print(_emailTextfield.text);
//   print(_phoneTextfield.text);
//   print(_addressTextfield.text);
//   print(_selectedGender);
//
//   // {"firstname":"Rashisir","lastname":"Sadik","email": "testxx@gmail.com","phone": "9876543211","gender":"Male","dob":"2030-07-30","location":"GH 234 Hosue Germany","profile_pic": "/media/profile/business_1.png"}
//
//
//   try {
//     var response = await http.Client().put(
//       Uri.parse("${AppUrls.userdetails}$UserID/"),
//       headers: {
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//         "Authorization": "Bearer $userToken"
//       },
//       body: jsonEncode({
//         "firstname": _firstnameTextfield.text,
//         "lastname":_lastnameTextfield.text,
//         "email":_emailTextfield.text,
//         "phone":_phoneTextfield.text,
//         "gender":_selectedGender,
//         "location":_addressTextfield.text,
//
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       print(responseData);
//
//       EasyLoading.showSuccess("Profile updated successfully");
//       function_FetchUserDetails(UserID,userToken);
//       // Navigator.pushNamed( context, "/profile",);
//       Navigator.push( context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
//
//     } else {
//       EasyLoading.showError("Failed to load subgroups");
//     }
//   } catch (e) {
//     log("Error in API $e");
//     EasyLoading.showError("Error in API $e");
//
//   }
//
//
// }



file path:



import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_font.dart';

enum _SelectedTab { home, folder, person }

class FileManager extends StatefulWidget {
const FileManager({Key? key}) : super(key: key);

@override
State<FileManager> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
var _selectedTab = _SelectedTab.folder;

void _handleIndexChanged(int i) {
setState(() {
_selectedTab = _SelectedTab.values[i];
if (_selectedTab == _SelectedTab.person) {
Navigator.pushNamed(
context,
"/profile",
);
} else if (_selectedTab == _SelectedTab.home) {
Navigator.pushNamed(
context,
"/home",
);
} else if (_selectedTab == _SelectedTab.folder) {
Navigator.pushNamed(
context,
"/file_manager",
);
}
});
}








final List<Map<String, dynamic>> fileData = [
{
"id": 10,
"pdf_name": "Flight Chart File",
"pdf_file":
"http://127.0.0.1:8000/media/pdf/flight_and_airport_management_names.pdf",
"created_at": "2024-09-07 05:51:12",
"status": "1",
"group": {"id": 41, "name": " A6-FHD"},
"group_path": [
{"id": 39, "name": "AW189"},
{"id": 41, "name": " A6-FHD"}
],
"category": {"id": 57, "name": "ADNOC 1"},
"category_path": [
{"id": 53, "name": "OPS Documents"},
{"id": 56, "name": "Brown Envelop"},
{"id": 57, "name": "ADNOC 1"}
]
},
{
"id": 11,
"pdf_name": "Airport Management Sectoin",
"pdf_file": "http://127.0.0.1:8000/media/pdf/airportmanagement.pdf",
"created_at": "2024-09-07 05:52:00",
"status": "1",
"group": {"id": 41, "name": " A6-FHD"},
"group_path": [
{"id": 39, "name": "AW189"},
{"id": 41, "name": " A6-FHD"}
],
"category": {"id": 58, "name": "ADNOC 2"},
"category_path": [
{"id": 53, "name": "OPS Documents"},
{"id": 56, "name": "Brown Envelop"},
{"id": 58, "name": "ADNOC 2"}
]
},
{
"id": 14,
"pdf_name": "Deluxe Final Sealing",
"pdf_file":
"http://127.0.0.1:8000/media/pdf/NEW_BUNDUQ_MAP_13_AUG_2024.pdf",
"created_at": "2024-09-07 05:56:03",
"status": "1",
"group": {"id": 41, "name": " A6-FHD"},
"group_path": [
{"id": 39, "name": "AW189"},
{"id": 41, "name": " A6-FHD"}
],
"category": {"id": 61, "name": "CFM-DEVELOP"},
"category_path": [
{"id": 54, "name": "Aircraft Documents"},
{"id": 60, "name": "Charted Flights"},
{"id": 61, "name": "CFM-DEVELOP"}
]
},
{
"id": 15,
"pdf_name": "Airport Api Decorectoin",
"pdf_file": "http://127.0.0.1:8000/media/pdf/Text_Weather.pdf",
"created_at": "2024-09-07 05:57:16",
"status": "1",
"group": {"id": 41, "name": " A6-FHD"},
"group_path": [
{"id": 39, "name": "AW189"},
{"id": 41, "name": " A6-FHD"}
],
"category": {"id": 56, "name": "Brown Envelop"},
"category_path": [
{"id": 53, "name": "OPS Documents"},
{"id": 56, "name": "Brown Envelop"}
]
}
];




@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xFFF8F9FB),
extendBody: true,
body: Stack(
children: [
Image.asset(
WhiteBackground,
fit: BoxFit.cover,
width: double.infinity,
height: double.infinity,
),
Center(
child: ConstrainedBox(
constraints: BoxConstraints(maxWidth: 1200.0),
child: Column(
children: [
SizedBox(height: 20.0),
Container(
padding: EdgeInsets.all(35.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
// Logo
Image.asset(
RedBlackLogo,
height: 90.0,
),
Row(
children: [
Column(
crossAxisAlignment: CrossAxisAlignment.end,
children: [
Text(
'Capt. Alpha',
style: TextStyle(
fontSize: 22,
fontFamily: AppFont.OutfitFont,
color: Colors.black,
fontWeight: FontWeight.w500,
),
),
Text(
'A6-FHD',
style: TextStyle(
color: Color(0xFF969492),
fontSize: 14,
fontFamily: AppFont.OutfitFont,
fontWeight: FontWeight.w400,
),
),
],
),
SizedBox(width: 10.0),
CircleAvatar(
backgroundImage: AssetImage(dummyProfile),
radius: 30.0,
),
],
),
],
),
),
SizedBox(height: 10.0),
Padding(
padding: const EdgeInsets.symmetric(horizontal: 40.0),
child: Row(
children: [
Expanded(
flex: 4, // 40% of the screen
child: Container(
padding: EdgeInsets.all(5.0),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(25),
),
child: ListView(
shrinkWrap: true,
children: _buildExpansionTiles(fileData, 0),
),
),
),
SizedBox(
width: MediaQuery.of(context).size.width * 0.04),
Expanded(
flex: 6, // 50% of the screen
child: Container(
color: Colors.grey[200],
child: Center(
child: Text('Document Viewer',
style: TextStyle(fontSize: 24)),
),
),
),
],
),
),
],
),
),
),
],
),
bottomNavigationBar: Padding(
padding: EdgeInsets.only(
bottom: 5,
right:
MediaQuery.of(context).size.width * 0.18, // 10% of screen width
left: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
),
child: CrystalNavigationBar(
currentIndex: _SelectedTab.values.indexOf(_selectedTab),
indicatorColor: AppColor.primaryColor,
borderRadius: 10,
paddingR: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
height: 110,
unselectedItemColor: Colors.white70,
backgroundColor: AppColor.primaryColor,
splashBorderRadius: 10,
outlineBorderColor: Colors.black.withOpacity(0.1),
onTap: _handleIndexChanged,
enableFloatingNavBar: true,
enablePaddingAnimation: true,
items: [
CrystalNavigationBarItem(
icon: IconlyBold.home,
unselectedIcon: IconlyLight.home,
selectedColor: Colors.white,
),
CrystalNavigationBarItem(
icon: IconlyBold.folder,
unselectedIcon: IconlyLight.folder,
selectedColor: Colors.white,
),
CrystalNavigationBarItem(
icon: IconlyBold.user_3,
unselectedIcon: IconlyLight.user_1,
selectedColor: Colors.white,
),
],
),
),
);
}

List<Widget> _buildExpansionTiles(
List<Map<String, dynamic>> fileData, int level) {
final Map<String, Map<String, dynamic>> pathMap = {};
final Set<String> displayedPaths = {};

    // Organize files by category path
    for (var file in fileData) {
      final List<Map<String, dynamic>> categoryPath =
          List<Map<String, dynamic>>.from(file['category_path']);
      final String pdfName = file['pdf_name'];
      final String pdfFile = file['pdf_file'];

      String pathKey = categoryPath.map((e) => e['name']).join('/');
      if (!pathMap.containsKey(pathKey)) {
        pathMap[pathKey] = {'path': categoryPath, 'files': []};
      }
      pathMap[pathKey]!['files']
          .add({'pdf_name': pdfName, 'pdf_file': pdfFile});
    }

    // Generate the ExpansionTiles
    return pathMap.entries.map((entry) {
      final categoryPath = List<Map<String, dynamic>>.from(entry.value['path']);
      final files = List<Map<String, dynamic>>.from(entry.value['files']);

      return _buildPathExpansionTile(
          categoryPath, files, level, displayedPaths);
    }).toList();
}

Widget _buildPathExpansionTile(List<Map<String, dynamic>> path,
List<Map<String, dynamic>> files, int level, Set<String> displayedPaths) {
if (path.isEmpty) {
return SizedBox.shrink();
}

    final current = path.first;
    final remainingPath = path.sublist(1);

    final currentPathKey = path.map((e) => e['name']).join('/');

    if (displayedPaths.contains(currentPathKey)) {
      return SizedBox.shrink();
    }

    displayedPaths.add(currentPathKey);

    return ExpansionTile(
      collapsedShape: RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: 20.0 * (level + 1)),
        child: Image.asset(
          foldericon,
          width: 30.0,
          height: 30.0,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          current['name'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.020,
            fontFamily: AppFont.OutfitFont,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      children: [
        if (remainingPath.isEmpty && files.isNotEmpty)
          ...files.map((file) {
            return ListTile(
              contentPadding: EdgeInsets.only(left: 22.0),
              leading: Padding(
                padding: EdgeInsets.only(left: 22.0 * (level + 1)),
                child: Image.asset(
                  pdficon,
                  width: 30.0,
                  height: 30.0,
                ),
              ),
              title: Text(
                file['pdf_name'],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.019,
                  fontFamily: AppFont.OutfitFont,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              dense: true,
              tileColor: Colors.transparent,
              onTap: () {
                // Handle file tap
                print('Opening ${file['pdf_file']}');
              },
            );
          }).toList()
        else
          _buildPathExpansionTile(
              remainingPath, files, level + 1, displayedPaths),
      ],
    );
}
}

// import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';
//
// import '../../../utils/app_color.dart';
// import '../../../utils/app_constant.dart';
// import '../../../utils/app_font.dart';
//
// enum _SelectedTab { home, folder, person }
//
// class FileManager extends StatefulWidget {
//   const FileManager({Key? key}) : super(key: key);
//
//   @override
//   State<FileManager> createState() => _FileManagerState();
// }
//
// class _FileManagerState extends State<FileManager> {
//   var _selectedTab = _SelectedTab.folder;
//
//   void _handleIndexChanged(int i) {
//     setState(() {
//       _selectedTab = _SelectedTab.values[i];
//       if (_selectedTab == _SelectedTab.person) {
//         Navigator.pushNamed(
//           context,
//           "/profile",
//         );
//       } else if (_selectedTab == _SelectedTab.home) {
//         Navigator.pushNamed(
//           context,
//           "/home",
//         );
//       } else if (_selectedTab == _SelectedTab.folder) {
//         Navigator.pushNamed(
//           context,
//           "/file_manager",
//         );
//       }
//     });
//   }
//
//   final List<Map<String, dynamic>> fileData = [
//     {
//       "id": 1,
//       "pdf_name": "Flight Managment",
//       "pdf_file": "/media/pdf/flight_and_airport_management_names.pdf",
//       "created_at": "2024-08-15 11:00:51",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 40, "name": "Chapter 1 Maths"},
//       "category_path": [
//         {"id": 31, "name": "OPS Document"},
//         {"id": 33, "name": "Delay Doc"},
//         {"id": 36, "name": "Section 1"},
//         // {"id": 40, "name": "Chapter 1 Maths"}
//       ]
//     },
//     {
//       "id": 6,
//       "pdf_name": "Helicopter Management",
//       "pdf_file": "/media/pdf/Text-Weather_report.pdf",
//       "created_at": "2024-08-20 04:38:54",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 39, "name": "COMPUTER ELEMENT"},
//       "category_path": [
//         {"id": 32, "name": "Aircraft Document"},
//         {"id": 35, "name": "AS-G10 AirCraft"},
//         {"id": 39, "name": "AirCraft Path"}
//       ]
//     },
//     {
//       "id": 8,
//       "pdf_name": "Crew Management",
//       "pdf_file": "/media/pdf/API_Service_Documentation_aZwzf9b.pdf",
//       "created_at": "2024-08-23 08:44:49",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 36, "name": "Maths 10A"},
//       "category_path": [
//         {"id": 31, "name": "General Documents"},
//         {"id": 33, "name": "Aviation Reports"},
//         {"id": 36, "name": "DRB Document"}
//       ]
//     },
//     {
//       "id": 9,
//       "pdf_name": "Maths File",
//       "pdf_file": "/media/pdf/Main-Weather_report_2ASFnyu.pdf",
//       "created_at": "2024-08-23 08:45:54",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 36, "name": "Maths 10A"},
//       "category_path": [
//         {"id": 32, "name": "Aircraft Document"},
//         {"id": 35, "name": "AS-G10 AirCraft"},
//         {"id": 39, "name": "AirCraft Path"}
//       ]
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F9FB),
//       extendBody: true,
//       body: Stack(
//         children: [
//           Image.asset(
//             WhiteBackground,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: 1200.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20.0),
//                   Container(
//                     padding: EdgeInsets.all(35.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Logo
//                         Image.asset(
//                           RedBlackLogo,
//                           height: 90.0,
//                         ),
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   'Capt. Alpha',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontFamily: AppFont.OutfitFont,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Text(
//                                   'A6-FHD',
//                                   style: TextStyle(
//                                     color: Color(0xFF969492),
//                                     fontSize: 14,
//                                     fontFamily: AppFont.OutfitFont,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(width: 10.0),
//                             CircleAvatar(
//                               backgroundImage: AssetImage(dummyProfile),
//                               radius: 30.0,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 4, // 40% of the screen
//                           child: Container(
//                             padding: EdgeInsets.all(5.0),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: ListView(
//                               shrinkWrap: true,
//                               children: _buildExpansionTiles(fileData, 0),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.04),
//                         Expanded(
//                           flex: 6, // 50% of the screen
//                           child: Container(
//                             color: Colors.grey[200],
//                             child: Center(
//                               child: Text('Document Viewer',
//                                   style: TextStyle(fontSize: 24)),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.only(
//           bottom: 5,
//           right: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
//           left: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
//         ),
//         child: CrystalNavigationBar(
//           currentIndex: _SelectedTab.values.indexOf(_selectedTab),
//           indicatorColor: AppColor.primaryColor,
//           borderRadius: 10,
//           paddingR: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           height: 110,
//           unselectedItemColor: Colors.white70,
//           backgroundColor: AppColor.primaryColor,
//           splashBorderRadius: 10,
//           outlineBorderColor: Colors.black.withOpacity(0.1),
//           onTap: _handleIndexChanged,
//           enableFloatingNavBar: true,
//           enablePaddingAnimation: true,
//
//           items: [
//             CrystalNavigationBarItem(
//               icon: IconlyBold.home,
//               unselectedIcon: IconlyLight.home,
//               selectedColor: Colors.white,
//
//             ),
//
//             CrystalNavigationBarItem(
//               icon: IconlyBold.folder,
//               unselectedIcon: IconlyLight.folder,
//               selectedColor: Colors.white,
//             ),
//
//             CrystalNavigationBarItem(
//               icon: IconlyBold.user_3,
//               unselectedIcon: IconlyLight.user_1,
//               selectedColor: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildExpansionTiles(
//       List<Map<String, dynamic>> fileData, int level) {
//     final Map<String, Map<String, dynamic>> pathMap = {};
//     final Set<String> displayedPaths = {};
//
//     // Organize files by category path
//     for (var file in fileData) {
//       final List<Map<String, dynamic>> categoryPath =
//       List<Map<String, dynamic>>.from(file['category_path']);
//       final String pdfName = file['pdf_name'];
//       final String pdfFile = file['pdf_file'];
//
//       String pathKey = categoryPath.map((e) => e['name']).join('/');
//       if (!pathMap.containsKey(pathKey)) {
//         pathMap[pathKey] = {'path': categoryPath, 'files': []};
//       }
//       pathMap[pathKey]!['files']
//           .add({'pdf_name': pdfName, 'pdf_file': pdfFile});
//     }
//
//     // Generate the ExpansionTiles
//     return pathMap.entries.map((entry) {
//       final categoryPath = List<Map<String, dynamic>>.from(entry.value['path']);
//       final files = List<Map<String, dynamic>>.from(entry.value['files']);
//
//       return _buildPathExpansionTile(categoryPath, files, level, displayedPaths);
//     }).toList();
//   }
//
//   Widget _buildPathExpansionTile(
//       List<Map<String, dynamic>> path,
//       List<Map<String, dynamic>> files,
//       int level,
//       Set<String> displayedPaths) {
//     if (path.isEmpty) {
//       return SizedBox.shrink();
//     }
//
//     final current = path.first;
//     final remainingPath = path.sublist(1);
//
//     final currentPathKey = path.map((e) => e['name']).join('/');
//
//     if (displayedPaths.contains(currentPathKey)) {
//       return SizedBox.shrink();
//     }
//
//     displayedPaths.add(currentPathKey);
//
//     return ExpansionTile(
//       collapsedShape: RoundedRectangleBorder(
//         side: BorderSide.none,
//       ),
//       shape: RoundedRectangleBorder(
//         side: BorderSide.none,
//       ),
//       leading: Padding(
//         padding: EdgeInsets.only(left: 20.0 * (level + 1)),
//         child: Image.asset(
//           foldericon,
//           width: 30.0,
//           height: 30.0,
//         ),
//       ),
//       title: Padding(
//         padding: EdgeInsets.only(left: 10.0),
//         child: Text(
//           current['name'],
//           style: TextStyle(
//             fontSize: MediaQuery.of(context).size.width * 0.020,
//             fontFamily: AppFont.OutfitFont,
//             color: Colors.black,
//             fontWeight: FontWeight.w500,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       children: [
//         if (remainingPath.isEmpty && files.isNotEmpty)
//           ...files.map((file) {
//             return ListTile(
//               contentPadding: EdgeInsets.only(left: 22.0),
//               leading: Padding(
//                 padding: EdgeInsets.only(left: 22.0 * (level + 1)),
//                 child: Image.asset(
//                   pdficon,
//                   width: 30.0,
//                   height: 30.0,
//                 ),
//               ),
//               title: Text(
//                 file['pdf_name'],
//                 style: TextStyle(
//                   fontSize: MediaQuery.of(context).size.width * 0.019,
//                   fontFamily: AppFont.OutfitFont,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               dense: true,
//               tileColor: Colors.transparent,
//               onTap: () {
//                 // Handle file tap
//                 print('Opening ${file['pdf_file']}');
//               },
//             );
//           }).toList()
//         else
//           _buildPathExpansionTile(remainingPath, files, level + 1, displayedPaths),
//       ],
//     );
//   }
//
// }
//





//file:

import 'dart:convert';
import 'dart:io';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iconly/iconly.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_font.dart';
import '../../../utils/app_sp.dart';
import '../../../utils/app_urls.dart';

import 'package:http/http.dart' as http;

import '../profile/profile_screen.dart';

enum _SelectedTab { home, folder, person }

class FileManager extends StatefulWidget {
const FileManager({Key? key}) : super(key: key);

@override
State<FileManager> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
var _selectedTab = _SelectedTab.folder;

void _handleIndexChanged(int i) {
setState(() {
_selectedTab = _SelectedTab.values[i];
if (_selectedTab == _SelectedTab.person) {
Navigator.pushNamed(
context,
"/profile",
);
} else if (_selectedTab == _SelectedTab.home) {
Navigator.pushNamed(
context,
"/home",
);
} else if (_selectedTab == _SelectedTab.folder) {
Navigator.pushNamed(
context,
"/file_manager",
);
}
});
}

double _downloadProgress = 0.0;

final List<Map<String, dynamic>> data = [];

String userToken = '';
String fullName = '';
String selectedGroupName = '';
List<dynamic> apps = [];
String profilePic = '';
String UserID = '';

String selectedGroupId_id = '';

var profile = dummyProfile;

@override
void initState() {
super.initState();
getUserToken();
}

Future<void> getUserToken() async {
AppSp appSp = AppSp();
userToken = await appSp.getToken();
fullName = await appSp.getFullname();
selectedGroupName = await appSp.getSelectedgroup();
UserID = await appSp.getUserID();
profile = await appSp.getUserprofilepic();
selectedGroupId_id = await appSp.getSelectedgroupID();

    setState(() {
      selectedGroupId_id = selectedGroupId_id;
    });
    getFilesbyGroup();
}

@override
void dispose() {
super.dispose();
}

void getFilesbyGroup() async {
print("${AppUrls.documents}?group=$selectedGroupId_id");

    try {
      var response = await http.Client().get(
        Uri.parse("${AppUrls.documents}?group=$selectedGroupId_id"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);



        List<dynamic> fetchedData = responseData['data'];

        void extractDocuments(List<dynamic> data) {
          data.forEach((element) async {
            if (element['type'] == 'document') {
              // Print document details
              print('File Name: ${element['name']}');
              print('File URL: ${element['url']}');


              final String fileUrl = element['url'];
              final String fileName = fileUrl.split('/').last;

              print(fileName);
              print(fileUrl);

              // Show download progress and open file after downloading
              FileDownloadManager downloadManager = FileDownloadManager();
              await downloadManager.downloadFile(
                fileUrl,
                fileName,
                context,
                    (progress) {
                  setState(() {
                    _downloadProgress = progress;
                  });
                },
              );


            } else if (element['type'] == 'folder' && element['children'] != null) {
              // Recursively call for children if it's a folder
              extractDocuments(element['children']);
            }
          });
        }



        setState(() {
          fetchedData.forEach((element) {
            data.add({
              "name": element['name'],
              "type": element['type'],
              "id": element['id'],
              "children": element['children']
            });
          });
        });

        print("Data saved: $data");

        extractDocuments(fetchedData);



        // EasyLoading.showSuccess("Apps loaded successfully");
      } else {
        EasyLoading.showError("Failed to datas");
      }
    } catch (e) {
      print("$e");
      // EasyLoading.showError("Errorxxxxxxx in API $e");
    }
}

@override
Widget build(BuildContext context) {
Color progressColor = _downloadProgress >= 100
? Colors.green
: Colors.blue; // Color changes to green at 100% progress

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FB),
      extendBody: true,
      body: Stack(
        children: [
          Image.asset(
            WhiteBackground,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200.0),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo
                        Image.asset(
                          RedBlackLogo,
                          height: 90.0,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  fullName,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: AppFont.OutfitFont,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  selectedGroupName,
                                  style: TextStyle(
                                    color: const Color(0xFF969492),
                                    fontSize: 14,
                                    fontFamily: AppFont.OutfitFont,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10.0),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: FileImage(File(profile)),
                                radius: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 45,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(15.0),
                                    child: GradientProgressBar(
                                      progress: _downloadProgress /
                                          100, // Ensure _downloadProgress is between 0 and 100
                                    )),
                                ListView(
                                  shrinkWrap: true,
                                  children: data
                                      .map((item) => buildList(item))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        Expanded(
                          flex: 65, // 50% of the screen
                          child: Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Text('Document Viewer',
                                  style: TextStyle(fontSize: 24)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: 5,
          right:
              MediaQuery.of(context).size.width * 0.18, // 10% of screen width
          left: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
        ),
        child: CrystalNavigationBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          indicatorColor: AppColor.primaryColor,
          borderRadius: 10,
          paddingR: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 110,
          unselectedItemColor: Colors.white70,
          backgroundColor: AppColor.primaryColor,
          splashBorderRadius: 10,
          outlineBorderColor: Colors.black.withOpacity(0.1),
          onTap: _handleIndexChanged,
          enableFloatingNavBar: true,
          enablePaddingAnimation: true,
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.folder,
              unselectedIcon: IconlyLight.folder,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.user_3,
              unselectedIcon: IconlyLight.user_1,
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
}

Widget buildList(Map<String, dynamic> item, [double padding = 0.0]) {
if (item['type'] == 'folder') {
return InkWell(
hoverColor: Colors.transparent, // Remove hover color
onTap: () {
// Define your onTap action here for folders
},
child: ExpansionTile(
collapsedShape: RoundedRectangleBorder(
side: BorderSide.none,
),
shape: RoundedRectangleBorder(
side: BorderSide.none,
),
tilePadding:
EdgeInsets.only(left: padding + 10.0), // Add padding for folder
title: Text(item['name']),
leading: Image.asset(
foldericon,
width: 30.0,
height: 30.0,
),
children: item['children']
.map<Widget>((child) => buildList(
child, padding + 20.0)) // Increase padding for child items
.toList(),
),
);
} else if (item['type'] == 'document' && item.containsKey('children')) {
return InkWell(
hoverColor: Colors.transparent, // Remove hover color
onTap: () {
// Define your onTap action for documents with children
},
child: ExpansionTile(
collapsedShape: RoundedRectangleBorder(
side: BorderSide.none,
),
shape: RoundedRectangleBorder(
side: BorderSide.none,
),
tilePadding: EdgeInsets.only(
left: padding + 10.0), // Add padding for document with children
trailing: const SizedBox.shrink(), // No trailing icon
leading: const Icon(
Icons.keyboard_arrow_right_outlined), // Icon for document
title: Container(
padding: EdgeInsets.only(
left: 20.0,
top: 20,
bottom: 20), // Adjust inner padding for document
child: Row(
children: [
Image.asset(
pdficon,
width: 30.0,
height: 30.0,
),
const SizedBox(
width: 12.0), // Increase spacing between icon and text
Expanded(
child: Text(item['name'], overflow: TextOverflow.ellipsis),
),
],
),
),
children: item['children']
.map<Widget>((child) => buildList(
child, padding + 20.0)) // Increase padding for sub-items
.toList(),
),
);
} else {
return InkWell(
hoverColor: Colors.transparent, // Remove hover effect
onTap: () async {
final String fileUrl = item['url'];
final String fileName = fileUrl.split('/').last;

          print(fileName);
          print(fileUrl);

          // Show download progress and open file after downloading
          FileDownloadManager downloadManager = FileDownloadManager();
          await downloadManager.downloadFile(
            fileUrl,
            fileName,
            context,
            (progress) {
              setState(() {
                _downloadProgress = progress;
              });
            },
          );
        },
        child: Container(
          padding: EdgeInsets.only(
              left: padding + 10.0,
              top: 10.0,
              bottom: 10.0), // Add more padding for documents
          child: Row(
            children: [
              Image.asset(
                pdficon,
                width: 30.0,
                height: 30.0,
              ),
              const SizedBox(
                  width: 12.0), // Increase spacing between icon and text
              Expanded(
                child: Text(item['name'], overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      );
    }
}
}

class GradientProgressBar extends StatelessWidget {
final double progress;
final double width;
final double height;

GradientProgressBar({
required this.progress,
this.width = 250,
this.height = 20.0,
}) : assert(
progress >= 0 && progress <= 1, 'Progress must be between 0 and 1');

@override
Widget build(BuildContext context) {
final double validWidth = width.isFinite && width > 0 ? width : 100.0;

    return Container(
      width: 250,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300], // Background color
      ),
      child: Stack(
        children: [
          Container(
            width: validWidth * progress, // Fill based on progress
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.lightGreen, // Start color
                  Colors.green, // End color
                ],
                stops: [
                  0.0, // Position of start color
                  1.0, // Position of end color
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Center(
            child: Text(
              "${(progress * 100).toStringAsFixed(1)}%",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
}
}

class FileDownloadManager {
final Dio dio = Dio();

Future<void> downloadFile(
String url,
String fileName,
BuildContext context,
void Function(double) onProgress,
) async {
try {
// Get the directory to save the file
Directory appDocDir = await getApplicationDocumentsDirectory();
String savePath = "${appDocDir.path}/$fileName";

      // Check if the file already exists
      File file = File(savePath);
      if (await file.exists()) {
        print("File already exists at: $savePath");
        // Optionally, show a message to the user that the file exists or decide to overwrite it
        return;
      }

      // If file does not exist, proceed with downloading
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // Show download progress as a percentage
            double progress = (received / total * 100);
            print("Progress: $progress%");

            // Invoke the callback to update UI
            onProgress(progress);
          }
        },
      );

      print("File downloaded and saved at: $savePath");
    } catch (e) {
      EasyLoading.showError("$e");
      print("Error downloading file: $e");
    }
}
}


















//
// Error: FileSystemException: writeFrom failed, path = '/Users/macair/Library/Developer/CoreSimulator/Devices/B91C7C9C-412C-4D04-835E-D73BF62A0C48/data/Containers/Data/Application/1898B254-23A3-4DF6-A7CA-F5D05D32DA73/Documents/21nnvfUEPODc.pdf' (OS Error: No space left on device, errno = 28)
//

// Widget buildList(Map<String, dynamic> item, [double padding = 0.0]) {
//   if (item['type'] == 'folder') {
//     return InkWell(
//       hoverColor: Colors.grey[300], // Background color when hovered
//       child: ExpansionTile(
//         collapsedShape: RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         shape: RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         tilePadding:
//             EdgeInsets.only(left: padding + 10.0), // Add padding for folder
//         title: Text(item['name']),
//         leading: Image.asset(
//           foldericon,
//           width: 30.0,
//           height: 30.0,
//         ),
//         children: item['children']
//             .map<Widget>((child) => buildList(
//                 child, padding + 20.0)) // Increase padding for child items
//             .toList(),
//       ),
//     );
//   } else if (item['type'] == 'document' && item.containsKey('children')) {
//     return InkWell(
//       hoverColor: Colors.grey[300], // Background color when hovered
//       child: ExpansionTile(
//         collapsedShape: RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         shape: RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         tilePadding: EdgeInsets.only(
//             left: padding + 10.0), // Add padding for document with children
//         trailing: const SizedBox.shrink(), // No trailing icon
//         leading: const Icon(
//             Icons.keyboard_arrow_right_outlined), // Icon for document
//         title: Container(
//           padding: EdgeInsets.only(
//               left: 20.0,
//               top: 20,
//               bottom: 20), // Adjust inner padding for document
//           child: Row(
//             children: [
//               Image.asset(
//                 pdficon,
//                 width: 30.0,
//                 height: 30.0,
//               ),
//               const SizedBox(
//                   width: 12.0), // Increase spacing between icon and text
//               Expanded(
//                 child: Text(item['name'], overflow: TextOverflow.ellipsis),
//               ),
//             ],
//           ),
//         ),
//         children: item['children']
//             .map<Widget>((child) => buildList(
//                 child, padding + 20.0)) // Increase padding for sub-items
//             .toList(),
//       ),
//     );
//   } else {
//     return InkWell(
//       hoverColor: Colors.grey[300], // Background color when hovered
//       child: Container(
//         padding: EdgeInsets.only(
//             left: padding + 10.0,
//             top: 10.0,
//             bottom: 10.0), // Add more padding for documents
//         child: Row(
//           children: [
//             Image.asset(
//               pdficon,
//               width: 30.0,
//               height: 30.0,
//             ),
//             const SizedBox(
//                 width: 12.0), // Increase spacing between icon and text
//             Expanded(
//               child: Text(item['name'], overflow: TextOverflow.ellipsis),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';
//
// import '../../../utils/app_color.dart';
// import '../../../utils/app_constant.dart';
// import '../../../utils/app_font.dart';
//
// enum _SelectedTab { home, folder, person }
//
// class FileManager extends StatefulWidget {
//   const FileManager({Key? key}) : super(key: key);
//
//   @override
//   State<FileManager> createState() => _FileManagerState();
// }
//
// class _FileManagerState extends State<FileManager> {
//   var _selectedTab = _SelectedTab.folder;
//
//   void _handleIndexChanged(int i) {
//     setState(() {
//       _selectedTab = _SelectedTab.values[i];
//       if (_selectedTab == _SelectedTab.person) {
//         Navigator.pushNamed(
//           context,
//           "/profile",
//         );
//       } else if (_selectedTab == _SelectedTab.home) {
//         Navigator.pushNamed(
//           context,
//           "/home",
//         );
//       } else if (_selectedTab == _SelectedTab.folder) {
//         Navigator.pushNamed(
//           context,
//           "/file_manager",
//         );
//       }
//     });
//   }
//
//   final List<Map<String, dynamic>> fileData = [
//     {
//       "id": 1,
//       "pdf_name": "Flight Managment",
//       "pdf_file": "/media/pdf/flight_and_airport_management_names.pdf",
//       "created_at": "2024-08-15 11:00:51",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 40, "name": "Chapter 1 Maths"},
//       "category_path": [
//         {"id": 31, "name": "OPS Document"},
//         {"id": 33, "name": "Delay Doc"},
//         {"id": 36, "name": "Section 1"},
//         // {"id": 40, "name": "Chapter 1 Maths"}
//       ]
//     },
//     {
//       "id": 6,
//       "pdf_name": "Helicopter Management",
//       "pdf_file": "/media/pdf/Text-Weather_report.pdf",
//       "created_at": "2024-08-20 04:38:54",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 39, "name": "COMPUTER ELEMENT"},
//       "category_path": [
//         {"id": 32, "name": "Aircraft Document"},
//         {"id": 35, "name": "AS-G10 AirCraft"},
//         {"id": 39, "name": "AirCraft Path"}
//       ]
//     },
//     {
//       "id": 8,
//       "pdf_name": "Crew Management",
//       "pdf_file": "/media/pdf/API_Service_Documentation_aZwzf9b.pdf",
//       "created_at": "2024-08-23 08:44:49",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 36, "name": "Maths 10A"},
//       "category_path": [
//         {"id": 31, "name": "General Documents"},
//         {"id": 33, "name": "Aviation Reports"},
//         {"id": 36, "name": "DRB Document"}
//       ]
//     },
//     {
//       "id": 9,
//       "pdf_name": "Maths File",
//       "pdf_file": "/media/pdf/Main-Weather_report_2ASFnyu.pdf",
//       "created_at": "2024-08-23 08:45:54",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 36, "name": "Maths 10A"},
//       "category_path": [
//         {"id": 32, "name": "Aircraft Document"},
//         {"id": 35, "name": "AS-G10 AirCraft"},
//         {"id": 39, "name": "AirCraft Path"}
//       ]
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F9FB),
//       extendBody: true,
//       body: Stack(
//         children: [
//           Image.asset(
//             WhiteBackground,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: 1200.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20.0),
//                   Container(
//                     padding: EdgeInsets.all(35.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Logo
//                         Image.asset(
//                           RedBlackLogo,
//                           height: 90.0,
//                         ),
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   'Capt. Alpha',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontFamily: AppFont.OutfitFont,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Text(
//                                   'A6-FHD',
//                                   style: TextStyle(
//                                     color: Color(0xFF969492),
//                                     fontSize: 14,
//                                     fontFamily: AppFont.OutfitFont,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(width: 10.0),
//                             CircleAvatar(
//                               backgroundImage: AssetImage(dummyProfile),
//                               radius: 30.0,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 4, // 40% of the screen
//                           child: Container(
//                             padding: EdgeInsets.all(5.0),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: ListView(
//                               shrinkWrap: true,
//                               children: _buildExpansionTiles(fileData, 0),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.04),
//                         Expanded(
//                           flex: 6, // 50% of the screen
//                           child: Container(
//                             color: Colors.grey[200],
//                             child: Center(
//                               child: Text('Document Viewer',
//                                   style: TextStyle(fontSize: 24)),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.only(
//           bottom: 5,
//           right: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
//           left: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
//         ),
//         child: CrystalNavigationBar(
//           currentIndex: _SelectedTab.values.indexOf(_selectedTab),
//           indicatorColor: AppColor.primaryColor,
//           borderRadius: 10,
//           paddingR: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           height: 110,
//           unselectedItemColor: Colors.white70,
//           backgroundColor: AppColor.primaryColor,
//           splashBorderRadius: 10,
//           outlineBorderColor: Colors.black.withOpacity(0.1),
//           onTap: _handleIndexChanged,
//           enableFloatingNavBar: true,
//           enablePaddingAnimation: true,
//
//           items: [
//             CrystalNavigationBarItem(
//               icon: IconlyBold.home,
//               unselectedIcon: IconlyLight.home,
//               selectedColor: Colors.white,
//
//             ),
//
//             CrystalNavigationBarItem(
//               icon: IconlyBold.folder,
//               unselectedIcon: IconlyLight.folder,
//               selectedColor: Colors.white,
//             ),
//
//             CrystalNavigationBarItem(
//               icon: IconlyBold.user_3,
//               unselectedIcon: IconlyLight.user_1,
//               selectedColor: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildExpansionTiles(
//       List<Map<String, dynamic>> fileData, int level) {
//     final Map<String, Map<String, dynamic>> pathMap = {};
//     final Set<String> displayedPaths = {};
//
//     // Organize files by category path
//     for (var file in fileData) {
//       final List<Map<String, dynamic>> categoryPath =
//       List<Map<String, dynamic>>.from(file['category_path']);
//       final String pdfName = file['pdf_name'];
//       final String pdfFile = file['pdf_file'];
//
//       String pathKey = categoryPath.map((e) => e['name']).join('/');
//       if (!pathMap.containsKey(pathKey)) {
//         pathMap[pathKey] = {'path': categoryPath, 'files': []};
//       }
//       pathMap[pathKey]!['files']
//           .add({'pdf_name': pdfName, 'pdf_file': pdfFile});
//     }
//
//     // Generate the ExpansionTiles
//     return pathMap.entries.map((entry) {
//       final categoryPath = List<Map<String, dynamic>>.from(entry.value['path']);
//       final files = List<Map<String, dynamic>>.from(entry.value['files']);
//
//       return _buildPathExpansionTile(categoryPath, files, level, displayedPaths);
//     }).toList();
//   }
//
//   Widget _buildPathExpansionTile(
//       List<Map<String, dynamic>> path,
//       List<Map<String, dynamic>> files,
//       int level,
//       Set<String> displayedPaths) {
//     if (path.isEmpty) {
//       return SizedBox.shrink();
//     }
//
//     final current = path.first;
//     final remainingPath = path.sublist(1);
//
//     final currentPathKey = path.map((e) => e['name']).join('/');
//
//     if (displayedPaths.contains(currentPathKey)) {
//       return SizedBox.shrink();
//     }
//
//     displayedPaths.add(currentPathKey);
//
//     return ExpansionTile(
//       collapsedShape: RoundedRectangleBorder(
//         side: BorderSide.none,
//       ),
//       shape: RoundedRectangleBorder(
//         side: BorderSide.none,
//       ),
//       leading: Padding(
//         padding: EdgeInsets.only(left: 20.0 * (level + 1)),
//         child: Image.asset(
//           foldericon,
//           width: 30.0,
//           height: 30.0,
//         ),
//       ),
//       title: Padding(
//         padding: EdgeInsets.only(left: 10.0),
//         child: Text(
//           current['name'],
//           style: TextStyle(
//             fontSize: MediaQuery.of(context).size.width * 0.020,
//             fontFamily: AppFont.OutfitFont,
//             color: Colors.black,
//             fontWeight: FontWeight.w500,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       children: [
//         if (remainingPath.isEmpty && files.isNotEmpty)
//           ...files.map((file) {
//             return ListTile(
//               contentPadding: EdgeInsets.only(left: 22.0),
//               leading: Padding(
//                 padding: EdgeInsets.only(left: 22.0 * (level + 1)),
//                 child: Image.asset(
//                   pdficon,
//                   width: 30.0,
//                   height: 30.0,
//                 ),
//               ),
//               title: Text(
//                 file['pdf_name'],
//                 style: TextStyle(
//                   fontSize: MediaQuery.of(context).size.width * 0.019,
//                   fontFamily: AppFont.OutfitFont,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               dense: true,
//               tileColor: Colors.transparent,
//               onTap: () {
//                 // Handle file tap
//                 print('Opening ${file['pdf_file']}');
//               },
//             );
//           }).toList()
//         else
//           _buildPathExpansionTile(remainingPath, files, level + 1, displayedPaths),
//       ],
//     );
//   }
//
// }
//

































Column(
children: [
const SizedBox(height: 20),
Center(
child: Column(
children: [
Table(
border: TableBorder.all(
color: Colors.black26),
columnWidths: const {
0: FixedColumnWidth(80.0),
1: FixedColumnWidth(
120.0),
2: FixedColumnWidth(
120.0),
3: FixedColumnWidth(
120.0),
4: FixedColumnWidth(
160.0),
5: FixedColumnWidth(
150.0),
},
children: [
TableRow(children: [
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'DATE',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Aircraft Type',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Aircraft Registration',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
]),
],
),
Table(
border: TableBorder(
horizontalInside:
BorderSide(
color: Colors
.black26),
verticalInside:
BorderSide(
color: Colors
.black26),
right: BorderSide(
color:
Colors.black26),
left: BorderSide(
color: Colors
.black26)),
columnWidths: const {
0: FixedColumnWidth(
200.0),
1: FixedColumnWidth(
550.0),
},
children: [
TableRow(children: [
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Commander’s Name',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
]),
],
),
Table(
border: TableBorder.all(
color: Colors.black26),
columnWidths: const {
0: FixedColumnWidth(
200.0),
1: FixedColumnWidth(
120.0),
2: FixedColumnWidth(
140.0),
3: FixedColumnWidth(
120.0),
4: FixedColumnWidth(
170.0),
},
children: [
TableRow(children: [
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Crew Involved in Discretion',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'PIC',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'SIC',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
]),
],
),
const SizedBox(height: 15),
Row(
children: [
Expanded(
// Wrap this in an Expanded widget
child: Container(
child: RichText(
text: TextSpan(
style: TextStyle(
fontSize: 16,
fontFamily: AppFont
.OutfitFont,
fontWeight:
FontWeight
.w500,
color: Colors
.black, // Default color
),
children: [
TextSpan(
text:
'An aircraft commander may take discretion to reduce rest after considering the below points: \n',
),
TextSpan(
text:
' (Please check on the below ☑)',
style: TextStyle(
color: Colors
.red), // Change this to red
),
],
),
textAlign:
TextAlign.left,
),
),
),
],
),
const SizedBox(height: 8),
Card(
elevation: 0,
color: Colors.white,
shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
10),
side: BorderSide(
color: Colors.grey,
width: 0.5,
),
),
child: Padding(
padding:
const EdgeInsets.all(
20.0),
child: Column(
crossAxisAlignment:
CrossAxisAlignment
.start,
children: [
Column(
children: [
Row(
children: [
Checkbox(
value:
_isCheckedx,
activeColor:
AppColor
.primaryColor,
checkColor:
Colors
.white,
shape:
RoundedRectangleBorder(
side:
const BorderSide(
color: Colors
.grey,
width:
1.0,
),
borderRadius:
BorderRadius.circular(
4.0),
),
onChanged:
(bool?
value) {
setState(
() {
_isCheckedx =
value ??
false;
});
},
),
Expanded(
child:
Text(
'Taking note of the circumstances of other members of the crew to reduce the rest period.',
style:
TextStyle(
fontSize:
16,
fontFamily:
AppFont
.OutfitFont,
fontWeight:
FontWeight
.w600,
color: Colors
.black, // Default color
),
)), // Text next to checkbox
],
),
Row(
children: [
Checkbox(
value:
_isCheckedx,
activeColor:
AppColor
.primaryColor,
checkColor:
Colors
.white,
shape:
RoundedRectangleBorder(
side:
const BorderSide(
color: Colors
.grey,
width:
1.0,
),
borderRadius:
BorderRadius.circular(
4.0),
),
onChanged:
(bool?
value) {
setState(
() {
_isCheckedx =
value ??
false;
});
},
),
Expanded(
child:
Text(
'Reduced Rest Period is not used to reduce successive rest periods.',
style:
TextStyle(
fontSize:
16,
fontFamily:
AppFont
.OutfitFont,
fontWeight:
FontWeight
.w600,
color: Colors
.black, // Default color
),
)), // Text next to checkbox
],
),
Row(
children: [
Checkbox(
value:
_isCheckedx,
activeColor:
AppColor
.primaryColor,
checkColor:
Colors
.white,
shape:
RoundedRectangleBorder(
side:
const BorderSide(
color: Colors
.grey,
width:
1.0,
),
borderRadius:
BorderRadius.circular(
4.0),
),
onChanged:
(bool?
value) {
setState(
() {
_isCheckedx =
value ??
false;
});
},
),
Expanded(
child:
Text(
'If the preceding FDP was extended then, the rest period may be reduced provided that the subsequent allowable FDP is also reduced by the same amount.',
style:
TextStyle(
fontSize:
16,
fontFamily:
AppFont
.OutfitFont,
fontWeight:
FontWeight
.w600,
color: Colors
.black, // Default color
),
)), // Text next to checkbox
],
),
Row(
children: [
Checkbox(
value:
_isCheckedx,
activeColor:
AppColor
.primaryColor,
checkColor:
Colors
.white,
shape:
RoundedRectangleBorder(
side:
const BorderSide(
color: Colors
.grey,
width:
1.0,
),
borderRadius:
BorderRadius.circular(
4.0),
),
onChanged:
(bool?
value) {
setState(
() {
_isCheckedx =
value ??
false;
});
},
),
Expanded(
child:
Text(
'In NO circumstances, may a commander exercise discretion to reduce a rest period below 10 hours.',
style:
TextStyle(
fontSize:
16,
fontFamily:
AppFont
.OutfitFont,
fontWeight:
FontWeight
.w600,
color: Colors
.black, // Default color
),
)), // Text next to checkbox
],
),
Row(
children: [
Checkbox(
value:
_isCheckedx,
activeColor:
AppColor
.primaryColor,
checkColor:
Colors
.white,
shape:
RoundedRectangleBorder(
side:
const BorderSide(
color: Colors
.grey,
width:
1.0,
),
borderRadius:
BorderRadius.circular(
4.0),
),
onChanged:
(bool?
value) {
setState(
() {
_isCheckedx =
value ??
false;
});
},
),
Expanded(
child:
Text(
'This Discretion is taken due to emergency and NOT due to any commercial practices.',
style:
TextStyle(
fontSize:
16,
fontFamily:
AppFont
.OutfitFont,
fontWeight:
FontWeight
.w600,
color: Colors
.black, // Default color
),
)), // Text next to checkbox
],
),
],
),
],
),
),
),
const SizedBox(height: 15),
Table(
border: TableBorder(
horizontalInside:
BorderSide(
color: Colors
.black26),
verticalInside:
BorderSide(
color: Colors
.black26),
right: BorderSide(
color:
Colors.black26),
bottom: BorderSide(
color:
Colors.black26),
top: BorderSide(
color:
Colors.black26),
left: BorderSide(
color: Colors
.black26)),
columnWidths: const {
0: FixedColumnWidth(
350.0),
1: FixedColumnWidth(
200.0),
2: FixedColumnWidth(
200.0),
},
children: [
TableRow(children: [
Container(),
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'UTC** (hh:mm)',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'LT (hh:mm)',
textAlign: TextAlign
.center,
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
]),
],
),
Table(
border: TableBorder(
horizontalInside:
BorderSide(
color: Colors
.black26),
verticalInside:
BorderSide(
color: Colors
.black26),
right: BorderSide(
color:
Colors.black26),
bottom: BorderSide(
color:
Colors.black26),
left: BorderSide(
color: Colors
.black26)),
columnWidths: const {
0: FixedColumnWidth(
350.0),
1: FixedColumnWidth(
200.0),
2: FixedColumnWidth(
200.0),
},
children: [
TableRow(children: [
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Last duty Started',
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
]),
],
),
Table(
border: TableBorder(
horizontalInside:
BorderSide(
color: Colors
.black26),
verticalInside:
BorderSide(
color: Colors
.black26),
right: BorderSide(
color:
Colors.black26),
bottom: BorderSide(
color:
Colors.black26),
left: BorderSide(
color: Colors
.black26)),
columnWidths: const {
0: FixedColumnWidth(
350.0),
1: FixedColumnWidth(
200.0),
2: FixedColumnWidth(
200.0),
},
children: [
TableRow(children: [
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Last duty Ended',
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
]),
],
),
Table(
border: TableBorder(
horizontalInside:
BorderSide(
color: Colors
.black26),
verticalInside:
BorderSide(
color: Colors
.black26),
right: BorderSide(
color:
Colors.black26),
bottom: BorderSide(
color:
Colors.black26),
left: BorderSide(
color: Colors
.black26)),
columnWidths: const {
0: FixedColumnWidth(
350.0),
1: FixedColumnWidth(
400.0),
},
children: [
TableRow(children: [
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Rest Earned',
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
]),
],
),
Table(
border: TableBorder(
horizontalInside:
BorderSide(
color: Colors
.black26),
verticalInside:
BorderSide(
color: Colors
.black26),
right: BorderSide(
color:
Colors.black26),
bottom: BorderSide(
color:
Colors.black26),
left: BorderSide(
color: Colors
.black26)),
columnWidths: const {
0: FixedColumnWidth(
350.0),
1: FixedColumnWidth(
200.0),
2: FixedColumnWidth(
200.0),
},
children: [
TableRow(children: [
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Actual start of next FDP',
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
]),
],
),
Table(
border: TableBorder(
horizontalInside:
BorderSide(
color: Colors
.black26),
verticalInside:
BorderSide(
color: Colors
.black26),
right: BorderSide(
color:
Colors.black26),
bottom: BorderSide(
color:
Colors.black26),
left: BorderSide(
color: Colors
.black26)),
columnWidths: const {
0: FixedColumnWidth(
350.0),
1: FixedColumnWidth(
400.0),
},
children: [
TableRow(children: [
Padding(
padding:
EdgeInsets.all(
10.0),
child: Text(
'Rest Period Reduced By',
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color:
Colors.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
),
Padding(
padding:
const EdgeInsets
.all(0),
child: Container(
constraints:
const BoxConstraints(
minHeight: 10.0,
maxHeight: 100.0,
),
child:
const SingleChildScrollView(
child: TextField(
style: TextStyle(
fontSize:
16.0,
color: AppColor
.textColor),
scrollPhysics:
NeverScrollableScrollPhysics(),
decoration:
InputDecoration(
border:
InputBorder
.none,
contentPadding:
EdgeInsets.symmetric(
horizontal:
10.0),
),
),
),
),
),
]),
],
),
const SizedBox(height: 15),
Row(
crossAxisAlignment:
CrossAxisAlignment
.start,
children: [
Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment
.start,
children: [
Text(
"Commander's Reason For Extension",
style: TextStyle(
fontFamily: AppFont
.OutfitFont,
color: Colors
.black,
fontSize: 16,
fontWeight:
FontWeight
.w600,
),
),
const SizedBox(
height: 5),
Container(
// height:200,
constraints:
const BoxConstraints(
minHeight:
60.0, // Increased minHeight
maxHeight:
150.0, // Increased maxHeight
),
child:
SingleChildScrollView(
child:
TextField(
maxLines:
3, // Allow the TextField to expand vertically
decoration:
InputDecoration(
hintStyle:
const TextStyle(
color:
Color(0xFFCACAC9)),
border:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12),
borderSide:
const BorderSide(
color: Color(0xFFCACAC9)),
),
focusedBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12),
borderSide:
const BorderSide(
color: Color(0xFF626262)),
),
enabledBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12),
borderSide:
const BorderSide(
color: Color(0xFFCACAC9)),
),
contentPadding:
EdgeInsets.all(
16), // Add padding inside the TextField
),
),
),
),
],
),
),

                                                      const SizedBox(
                                                          width:
                                                              16), // Spacing between fields
                                                      // Right Side Fields (Date and Number)
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(
                                                              height: 20),
                                                          SizedBox(
                                                            width: 120,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  'Signature',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        AppFont
                                                                            .OutfitFont,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Checkbox(
                                                                  value:
                                                                      _isCheckedx,
                                                                  activeColor:
                                                                      AppColor
                                                                          .primaryColor,
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side:
                                                                        const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      _isCheckedx =
                                                                          value ??
                                                                              false;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Date',
                                                                hintStyle: const TextStyle(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFF626262)),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            8),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Operator's Remarks/Actions taken",
                                                              style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .OutfitFont,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Container(
                                                              // height:200,
                                                              constraints:
                                                                  const BoxConstraints(
                                                                minHeight:
                                                                    60.0, // Increased minHeight
                                                                maxHeight:
                                                                    150.0, // Increased maxHeight
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child:
                                                                    TextField(
                                                                  maxLines:
                                                                      3, // Allow the TextField to expand vertically
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintStyle:
                                                                        const TextStyle(
                                                                            color:
                                                                                Color(0xFFCACAC9)),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFFCACAC9)),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFF626262)),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFFCACAC9)),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            16), // Add padding inside the TextField
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                          width:
                                                              16), // Spacing between fields
                                                      // Right Side Fields (Date and Number)
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(
                                                              height: 20),
                                                          SizedBox(
                                                            width: 120,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  'Signature',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        AppFont
                                                                            .OutfitFont,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Checkbox(
                                                                  value:
                                                                      _isCheckedx,
                                                                  activeColor:
                                                                      AppColor
                                                                          .primaryColor,
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side:
                                                                        const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      _isCheckedx =
                                                                          value ??
                                                                              false;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Date',
                                                                hintStyle: const TextStyle(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFF626262)),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            8),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SizedBox(
                                                    width: 150.00,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ButtonStyle(
                                                        foregroundColor:
                                                            WidgetStateProperty
                                                                .resolveWith(
                                                                    (states) {
                                                          if (states.contains(
                                                              WidgetState
                                                                  .pressed)) {
                                                            return Colors
                                                                .white70;
                                                          }
                                                          return Colors.white;
                                                        }),
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .resolveWith(
                                                                    (states) {
                                                          if (states.contains(
                                                              WidgetState
                                                                  .pressed)) {
                                                            return (Color(
                                                                0xFFE8374F));
                                                          }
                                                          return (Color(
                                                              0xFFAA182C));
                                                        }),
                                                        padding:
                                                            WidgetStateProperty.all(
                                                                const EdgeInsets
                                                                    .all(8.0)),
                                                        shape:
                                                            WidgetStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Save',
                                                        style: TextStyle(
                                                          fontFamily: AppFont
                                                              .OutfitFont,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),