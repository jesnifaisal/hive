import 'package:hive/hive.dart';
import 'package:todo/usermodel.dart';

class HiveMethods {
  String hiveBox = "hive_db";

  //Adding user model to hive db
  addUser(UserModel userModel) async {
    var box = await Hive.openBox(hiveBox); //open the hive box before writing
    var mapUserData = userModel.toMap(userModel);
    await box.add(mapUserData);
    Hive.close(); //closing the hive box
  }

  //Reading all the users data
  Future<List<UserModel>> getUserLists() async {
    var box = await Hive.openBox(hiveBox);
    List<UserModel> users = [];

    for (int i = box.length - 1; i >= 1; i--) {
      var userMap = box.getAt(i);
      users.add(UserModel.fromMap(Map.from(userMap)));
    }
    return users;
  }

  //Deleting one data from hive DB
  deleteUser(int id) async {
    var box = await Hive.openBox(hiveBox);
    await box.deleteAt(id);
  }

  //Deleting whole data from Hive
  deleteAllUsers() async {
    var box = await Hive.openBox(hiveBox);
    await box.clear();
  }
}
