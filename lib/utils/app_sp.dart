import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppSp {
  Future<bool> setIsLogged(bool login) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isLogged", login);
  }

  Future<bool> getIsLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogged") ?? false;
  }

  Future<bool> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? '';
  }




  Future<bool> setUserDetails(String userDetails) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userdetails", userDetails);
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDetailsString = prefs.getString("userdetails");

    if (userDetailsString != null && userDetailsString.isNotEmpty) {
      return jsonDecode(userDetailsString);
    } else {
      return {};
    }
  }


  //firstname
  Future<bool> setFirstname(String Firstname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("Firstname", Firstname);
  }

  Future<String> getFirstname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("Firstname") ?? '';
  }

  //lastname
  Future<bool> setLastname(String Lastname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("Lastname", Lastname);
  }

  Future<String> getLastname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("Lastname") ?? '';
  }

  //fullname
  Future<bool> setFullname(String Fullname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("fullName", Fullname);
  }

  Future<String> getFullname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("fullName") ?? '';
  }

  //profilepicutre
  Future<bool> setUserprofilepic(String Userprofilepic) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("Userprofilepic", Userprofilepic);
  }

  Future<String> getUserprofilepic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("Userprofilepic") ?? '';
  }

  //userID
  Future<bool> setUserID(int userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userID", userid.toString());
  }


  Future<String> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID") ?? '';
  }

  //userSelectedGroup
  Future<bool> setSelectedgroup(String Selectedgroup) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("selectedGroup", Selectedgroup);
  }

  Future<String> getSelectedgroup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selectedGroup") ?? '';
  }

  Future<bool> setSelectedgroupID(String SelectedgroupID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("selectedGroupID", SelectedgroupID);
  }

  Future<String> getSelectedgroupID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selectedGroupID") ?? '';
  }



  //dahboard Apps
  Future<bool> setAppslist(String appsList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("appslist", appsList);
  }

  Future<List<dynamic>> getAppslist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? appsListString = prefs.getString("appslist");

    if (appsListString != null && appsListString.isNotEmpty) {
      return jsonDecode(appsListString);
    } else {
      return [];
    }
  }

  //favouritesList Apps
  Future<bool> setFavourites(String favourites) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("favourites", favourites);
  }

  Future<List<dynamic>> getFavourites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favouritesListString = prefs.getString("favourites");

    if (favouritesListString != null && favouritesListString.isNotEmpty) {
      return jsonDecode(favouritesListString);
    } else {
      return [];
    }
  }


//pdffiles

  Future<bool> setPdfdocuments(String Pdfdocuments) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("Pdfdocuments", Pdfdocuments);
  }

  Future<List<dynamic>> getPdfdocuments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? PdfdocumentsListString = prefs.getString("Pdfdocuments");

    if (PdfdocumentsListString != null && PdfdocumentsListString.isNotEmpty) {
      return jsonDecode(PdfdocumentsListString);
    } else {
      return [];
    }
  }




  //userSelectedMainGroup
  Future<bool> setSelected_Maingroup(String SelectedMaingroup) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("selectedMainGroup", SelectedMaingroup);
  }

  Future<String> getSelected_Maingroup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selectedMainGroup") ?? '';
  }

  Future<bool> setSelected_MaingroupID(String SelectedMaingroupID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("selectedMainGroupID", SelectedMaingroupID);
  }

  Future<String> getSelected_MaingroupID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selectedMainGroupID") ?? '';
  }












}

