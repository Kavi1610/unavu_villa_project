import 'package:get/get.dart';

class ButtonController extends GetxController {
  var isButtonClicked = false.obs; // Observable boolean

  void makebuttontrue() {
    isButtonClicked.value = true;
  }

  void buttondefault() {
    isButtonClicked.value = false;
  }
}
