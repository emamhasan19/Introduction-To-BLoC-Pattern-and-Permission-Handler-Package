import 'package:flutter/material.dart';
import 'package:login_using_bloc/features/home/pages/image_page.dart';
import 'package:login_using_bloc/features/home/pages/location_page.dart';
import 'package:login_using_bloc/features/home/pages/sound_page.dart';
import 'package:login_using_bloc/features/home/pages/storage_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Home Screen",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImagePage(),
                    ),
                  );
                },
                child: const Text("Image"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationPage(),
                    ),
                  );
                },
                child: const Text("Location"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SoundRecordingPage(),
                    ),
                  );
                },
                child: const Text("Sound"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoragePage(),
                    ),
                  );
                },
                child: const Text("Storage"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
