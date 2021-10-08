import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  Rx<int> days;
  Future<int> getboxTask(int day) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    days.value = pref.getInt('boxNumber');
  }

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    // fetchApi();
    super.onInit();
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    // showIntroDialog();
    super.onReady();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    // closeStream();
    super.onClose();
  }
}
