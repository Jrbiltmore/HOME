import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late final WebSocketChannel _channel;
  final _controller = StreamController<dynamic>();

  WebSocketService(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel.stream.listen((data) {
      _controller.add(json.decode(data));
    }, onDone: () {
      _controller.close();
    }, onError: (error) {
      _controller.addError(error);
    });
  }

  Stream<dynamic> get stream => _controller.stream;

  void send(dynamic data) {
    _channel.sink.add(json.encode(data));
  }

  void close() {
    _channel.sink.close();
    _controller.close();
  }
}