import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecordingPage extends StatefulWidget {
  @override
  _SoundRecordingPageState createState() => _SoundRecordingPageState();
}

class _SoundRecordingPageState extends State<SoundRecordingPage> {
  late AudioPlayer _audioPlayer;
  late PermissionStatus _permissionStatus;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    final status = await Permission.microphone.status;
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    setState(() {
      _permissionStatus = status;
    });
    if (_permissionStatus.isGranted) {
      setState(() {
        _isRecording = true;
      });

      // Start recording logic here
    } else if (_permissionStatus.isDenied ||
        _permissionStatus.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission Required'),
            content:
                Text('Please grant microphone permission to start recording.'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Open Settings'),
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
    // else {
    //   await _requestMicrophonePermission();
    // }
  }

  Future<void> _stopRecording() async {
    setState(() {
      _isRecording = false;
    });

    // Stop recording logic here
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sound Recording'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRecording) Text('Recording in progress...'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
          ],
        ),
      ),
    );
  }
}
