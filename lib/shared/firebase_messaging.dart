import 'dart:async';
import 'package:firebase/firebase.dart' as fire;

class FBMessaging {
  FBMessaging._();
  static FBMessaging _instance = FBMessaging._();
  static FBMessaging get instance => _instance;
  fire.Messaging _mc;
  String _token;

  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  void close() {
    _controller?.close();
  }

  Future<void> init() async {
    _mc = fire.messaging();
    _mc.usePublicVapidKey('AAAAirbssr0:APA91bHw_j9XwEKInxQJ2fXK4WghuK4bqw5dDZyfMitgZ5di5D77z6aeEuXNM5W8mc5rFz-gIC-h9cw-b0bGiYJPEUNWkUeiPntqYceAKxIl7pabSSI9m_8jhpCGbzwfbcZ5rFhebLMA');
    _mc.onMessage.listen((event) {
      _controller.add(event?.data);
    });
  }

  Future requestPermissiont() async {
    await init();
    return _mc.requestPermission();
  }

  Future<String> getToken([bool force = false]) async {
    if (force || _token == null) {
      await requestPermissiont();
      _token = await _mc.getToken();
    }
    return _token;
  }
}