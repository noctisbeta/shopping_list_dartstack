import 'dart:async';

import 'package:common/logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

base class WebSocketHelper {
  WebSocketHelper(this.uri) {
    _channel = WebSocketChannel.connect(uri);

    unawaited(
      _channel!.sink.done.then((value) {
        LOG.i('Channel closed: $value');
      }),
    );
  }

  final Uri uri;

  WebSocketChannel? _channel;

  Future<WebSocketChannel> get channel async {
    await _channel!.ready;
    return _channel!;
  }

  Future<void> dispose() async {
    await _channel?.sink.close();
  }
}
