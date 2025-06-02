import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _mcuPassword = "1111"; // Той самий, що у мікроконтролері
  String userEmail = 'example@email.com';
  String userName = 'User';

  void _startQRCodeScan() async {
    String? qrData = await Navigator.push(context, MaterialPageRoute(
      builder: (_) => QRViewExample(),
    ));

    if (qrData != null) {
      // Відправка даних на мікроконтролер
      var url = Uri.parse('http://192.168.1.150/configure');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: '{"password":"$_mcuPassword","payload":"$qrData"}',
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Результат"),
            content: Text("Відповідь від МК: ${response.body}"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Помилка відправки на МК")),
        );
      }
    }
  }

  void _showPasswordDialog() {
    TextEditingController pwdController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Введіть пароль для МК"),
        content: TextField(
          controller: pwdController,
          obscureText: true,
          decoration: InputDecoration(labelText: "Пароль"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Скасувати"),
          ),
          TextButton(
            onPressed: () {
              if (pwdController.text == _mcuPassword) {
                Navigator.pop(context);
                _startQRCodeScan();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Невірний пароль")),
                );
              }
            },
            child: Text("Підтвердити"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Профіль")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Ім’я: $userName"),
            Text("Email: $userEmail"),
            ElevatedButton(
              onPressed: _showPasswordDialog,
              child: Text("Сканувати QR для МК"),
            ),
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сканер QR')),
      body: MobileScanner(
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          if (barcode.rawValue != null) {
            Navigator.pop(context, barcode.rawValue);
            break; 
          }
        }
      },
    ),
    );
  }
}
