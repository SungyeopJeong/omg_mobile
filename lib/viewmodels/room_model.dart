import 'package:flutter/material.dart';
import 'package:screen_badminton_mobile/services/socket.dart';

class RoomModel extends ChangeNotifier {
  late SocketService _socketService;
  SocketService get socketService => _socketService;
  String? _code;
  bool joined = false;

  RoomModel() {
    _socketService = SocketService();
  }

  void connect() {
    _socketService.connect();
  }

  void input(String code) {
    _socketService.off('ready $_code');
    _code = code;
  }

  void join() {
    _socketService.emit('join', _code);
    _socketService.on('ready $_code', (data) {
      joined = data;
      notifyListeners();
    });
  }

  void exit() {
    _socketService.off('ready $_code');
    _code = null;
    joined = false;
    notifyListeners();
  }
}
