import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() async {
  final ip = InternetAddress.anyIPv4;
  var port = int.parse(Platform.environment['PORT'] ?? '8080');

  print(DateTime.now());
  print('Vladyslav Veshnevskyi');
  print('Port - $port\n\n');

  Future<ServerSocket> serverFuture = ServerSocket.bind(ip, port);
  serverFuture.then((ServerSocket server) {
    server.listen((Socket socket) {
      socket.write('connecting...\n');
      socket.listen((List<int> data) async {
        String ip = socket.remoteAddress.address;

        var uri = Uri.parse('https://ipapi.co/$ip/json/');

        Response response = await http.get(uri);

        print('New connection: $ip');

        var decode = json.decode(response.body);
        var tmp = decode.containsKey("error");
        if (tmp) {
          String err = "invalid ip address... -> $ip";
          String reason = "reason -> ${decode["reason"]}";

          print(err);
          print(reason);

          socket.write(err + "\n");
          socket.write(reason);
          socket.close();
          return;
        }

        socket.write(ip + '\n');
        socket.write(DateFormat.Hms().format(DateTime.now()));
        socket.close();
      });
    });
  });
}
