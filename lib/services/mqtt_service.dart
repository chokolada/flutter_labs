import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final _client = MqttServerClient.withPort(
    'wss://mqtt-dashboard.com/mqtt',
    'clientId-hDsvMQ6bin',
    8884,
  );

  Function(String message)? onMessageReceived;

  Future<void> connect() async {
    _client.useWebSocket = true;          // Підключення через WebSocket
    _client.secure = false;               // TLS (бо порт 8884)
    _client.logging(on: false);
    _client.keepAlivePeriod = 20;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('clientId-hDsvMQ6bin')
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    _client.connectionMessage = connMessage;

    _client.onConnected = () => print('MQTT Connected');
    _client.onDisconnected = () => print('MQTT Disconnected');

    try {
      await _client.connect();
    } catch (e) {
      print('Connection failed: $e');
      _client.disconnect();
      return;
    }

    if (_client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected!');
      _client.subscribe('sensor/temperature', MqttQos.atMostOnce);

      _client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
        final recMess = messages[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print('Received: $payload');
        if (onMessageReceived != null) onMessageReceived!(payload);
      });
    } else {
      print('Connection failed: ${_client.connectionStatus}');
      _client.disconnect();
    }
  }

  void disconnect() => _client.disconnect();
}
