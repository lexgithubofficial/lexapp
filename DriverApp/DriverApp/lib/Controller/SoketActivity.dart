
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SoketActivity extends GetxController implements GetxService {

  String jsonString = '{"action": "check_driver", "user_id": 35, "km": "21","bid": "150","from": "Borivali","to": "Malad"}';

  intitzation() async {
    try {
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      var channel = WebSocketChannel.connect(wsUrl);
      print('Status of channel'+channel.toString());
      //channel.sink.add(jsonString);
      channel.stream.listen((message) {
        channel.sink.add(jsonString);
        // channel.sink.close(status.goingAway);
        print("result " + message);
        Get.showSnackbar(
          GetSnackBar(
            title: "RESULT",
            message: message,
            duration: const Duration(seconds: 3),
          ),
        );
      });
    } on Exception catch (_) {
      // make it explicit that this function can throw exceptions
      print("eorror " + _.toString());
      rethrow;
    }

  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
