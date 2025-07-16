import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'app_sp.dart';
import 'app_urls.dart';

Future<void> function_FetchUserDetails(String userID, String userToken) async {

  print("${AppUrls.userdetails}$userID/");
  try {
    var response = await http.Client().get(
      Uri.parse("${AppUrls.userdetails}$userID/"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $userToken"
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      AppSp().setUserDetails(jsonEncode(responseData['data']));

      AppSp().setFirstname(responseData['data']['firstname']);
      AppSp().setLastname(responseData['data']['lastname']);
      AppSp().setFullname( "${responseData['data']['firstname']} ${responseData['data']['lastname']}");
      AppSp().setUserID(responseData['data']['id']);

      String localIconPath = await downloadAppIcon( responseData['data']['profile_pic'], "${responseData['data']['firstname']}_${responseData['data']['lastname']}");

      AppSp().setUserprofilepic(localIconPath);

    } else {
      final responseData = json.decode(response.body);
      print(responseData['message']);
    }
  } catch (e) {
    log("Error in API $e");
  }
}


Future<String> downloadAppIcon(String iconUrl, String appName) async {
  try {
    var response = await http.get(Uri.parse(iconUrl));

    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/app_profiles';

      final dir = Directory(path);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      File file = File('$path/${appName}_profilepic.png');
      await file.writeAsBytes(response.bodyBytes);

      return file.path;
    } else {
      print('Failed to download icon');
      return '';
    }
  } catch (e) {
    print('Error downloading icon: $e');
    return '';
  }
}
