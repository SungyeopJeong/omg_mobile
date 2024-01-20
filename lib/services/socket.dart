import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  late Socket _socket;
  Socket get socket => _socket;

  SocketService() {
    _socket = io(
      dotenv.get('BASE_URL'),
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );
  }

  void connectIfNot() {
    if (_socket.disconnected) _socket.connect();
  }

  void on(String event, Function(dynamic) handler) {
    _socket.on(event, handler);
  }

  void off(String event) {
    _socket.off(event);
  }

  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }
}
