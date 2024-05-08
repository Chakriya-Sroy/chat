import 'package:chat/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  RxList<UserModel> users = RxList();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final currentUserEmail = pref.getString("email");
      print(currentUserEmail);
      if(currentUserEmail != null) {
        QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection("users").get();
        
        users.clear();
        snapshot.docs.forEach((doc) {
          Map<String, dynamic> userData = doc.data();
          if (userData['email'].toString() != currentUserEmail) {
            users.add(UserModel.fromJson(userData));
          }
        });
      }
    } catch (e) {
      // Handle errors if any
      print("Error fetching users: $e");
    }
  }

  List<UserModel> findUser(String uid) {
    // Use where method to filter users list based on condition
    return users.where((user) => user.uid.contains(uid)).toList();
  }
}
