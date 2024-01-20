import 'package:flutter/material.dart';
import 'package:screen_badminton_mobile/models/sensor.dart';
import 'package:screen_badminton_mobile/models/user.dart';
import 'package:screen_badminton_mobile/services/socket.dart';

class GameModel extends ChangeNotifier {
  late SocketService _socketService;
  SocketService get socketService => _socketService;
  User user = User(name: '', code: '');
  Sensor sensor = Sensor();
  bool joined = false, requested = false;

  GameModel() {
    _socketService = SocketService();
  }

  void connectIfNot() {
    _socketService.connectIfNot();
  }

  void setUser(String name, String code) {
    if (user.code.isNotEmpty) _socketService.off('ready ${user.code}');
    user.name = name;
    user.code = code;
  }

  void join() {
    _socketService.emit('join', {
      'name': user.name,
      'code': user.code,
    });
    _socketService.on('ready ${user.code}', (data) {
      user.id = data['id'];
      joined = data['joined'];
      if (joined) {
        _socketService.on('request ${user.code}', (data) {
          requested = true;
          notifyListeners();
        });
      }
      notifyListeners();
    });
  }

  void send() {
    _socketService.emit('send', {'code': user.code}..addAll(sensor.toJson()));
  }

  void exit() {
    _socketService.off('ready ${user.code}');
    _socketService.socket.disconnect();
    joined = false;
    requested = false;
    notifyListeners();
  }
}
