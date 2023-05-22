import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePage extends StatefulWidget {
  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  late PermissionStatus _permissionStatus;

  @override
  void initState() {
    super.initState();
    checkPermissionStatus();
  }

  Future<void> checkPermissionStatus() async {
    final status = await Permission.storage.status;
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> requestPermission() async {
    final status = await Permission.storage.request();
    setState(() {
      _permissionStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Storage Permission')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Permission Status: $_permissionStatus',
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                requestPermission();
              },
              child: Text('Request Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
