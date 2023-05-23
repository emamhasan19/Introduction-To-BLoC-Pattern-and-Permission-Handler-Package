import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  late String result = "";

  @override
  void initState() {
    super.initState();
    requestStoragePage();
  }

  Future<void> requestStoragePage() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      setState(() {
        result = 'Storage permission granted';
      });
    } else if (status.isDenied) {
      setState(() {
        result = 'Storage permission denied';
      });
    } else if (status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Please grant Storage permission to use this app.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> pickFile() async {
    print("huh");
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        // Display the picked file path or other details
        String filePath = result.files.single.path!;
        // Do something with the file path
        print('Picked file path: $filePath');
      });
    } else {
      // User canceled the file picking
      print('User canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storage Permission Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result),
            ElevatedButton(
              onPressed: pickFile,
              child: const Text('Pick File'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class StoragePage extends StatefulWidget {
//   @override
//   _StoragePageState createState() => _StoragePageState();
// }
//
// class _StoragePageState extends State<StoragePage> {
//   late PermissionStatus _permissionStatus;
//
//   @override
//   void initState() {
//     super.initState();
//     checkPermissionStatus();
//   }
//
//   Future<void> checkPermissionStatus() async {
//     final status = await Permission.storage.status;
//     setState(() {
//       _permissionStatus = status;
//     });
//   }
//
//   Future<void> requestPermission() async {
//     final status = await Permission.storage.request();
//     setState(() {
//       _permissionStatus = status;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text('Storage Permission'),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Permission Status: $_permissionStatus',
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 requestPermission();
//               },
//               child: Text('Request Permission'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
