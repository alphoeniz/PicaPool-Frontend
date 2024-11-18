import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketService {
  IO.Socket? socket;
  int? currentUserId;

  IO.Socket? createSocketConnection(int id, String roomId) {
    disconnectSocket();

    String url = "${dotenv.env['backendUrl']}";

    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'query': {
        'userId': id,
        'roomId': roomId,
      },
    });

    socket!.connect();

    socket!.onDisconnect((_) {
      debugPrint('Disconnected from Socket.io Server');
    });

    return socket;
  }

  void sendMessage(String content) {
    if (!isConnected()) {
      debugPrint('Socket is not connected, message not sent.');
      return;
    }

    final messageData = {
      'content': content,
      'timestamp':
          DateTime.now().toIso8601String(),
    };

    socket!.emit('message', messageData);
  }

  void disconnectSocket() {
    if (isConnected()) {
      socket?.disconnect(); 
      debugPrint('Socket disconnected.');
    }
  }

  bool isConnected() {
    return socket?.connected ?? false;
  }
}
