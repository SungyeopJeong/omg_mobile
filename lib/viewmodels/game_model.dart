import 'package:flutter/material.dart';
import 'package:screen_badminton_mobile/models/sensor.dart';
import 'package:screen_badminton_mobile/models/user.dart';
import 'package:screen_badminton_mobile/services/socket.dart';

class GameModel extends ChangeNotifier {
  late SocketService _socketService;
  SocketService get socketService => _socketService;
  User? user;
  Sensor sensor = Sensor();
  bool joined = false, requested = false;

  GameModel() {
    _socketService = SocketService();
  }

  void connectIfNot() {
    _socketService.connectIfNot();
  }

  void setUser(String name, String code) {
    if (user == null) {
      user = User(name: name, code: code);
    } else {
      _socketService.off('ready ${user!.code}');
      user!.name = name;
      user!.code = code;
    }
  }

  void join() {
    _socketService.emit('join', {
      'name': user?.name,
      'code': user?.code,
    });
    _socketService.on('ready ${user?.code}', (data) {
      if (data['name'] == user?.name) {
        switch (data['statusCode']) {
          case 201:
            /* join */
            joined = true;
            _socketService.on('request ${user?.code}', (data) {
              requested = true;
              notifyListeners();
            });
            notifyListeners();
            break;
          case 401:
            /* wrong code */
            break;
          case 200:
            /* exit */
            _socketService.off('ready ${user?.code}');
            _socketService.socket.disconnect();
            joined = false;
            requested = false;
            notifyListeners();
            break;
          default:
          /* duplicate name */
        }
      }
    });
  }

  void send() {
    _socketService.emit(
        'send',
        {
          'name': user?.name,
          'code': user?.code,
        }..addAll(sensor.toJson()));
  }

  void exit() {
    _socketService.emit('exit', {
      'name': user?.name,
      'code': user?.code,
    });
  }
}
