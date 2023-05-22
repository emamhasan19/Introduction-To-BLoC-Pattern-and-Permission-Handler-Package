import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Image'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            imageFile == null
                ? Image.asset(
                    "images/pic.png",
                    height: 300,
                    width: 300,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.file(
                      imageFile!,
                      height: 300.0,
                      width: 300.0,
                      fit: BoxFit.fill,
                    )),
            const SizedBox(
              height: 20.0,
            ),

            ElevatedButton(
              onPressed: () async {
                PermissionStatus status = await Permission.camera.request();
                if (status.isGranted) {
                  showImagePicker(context);
                } else {
                  print('no permission provided');
                }
              },
              child: const Text('Select Image'),
            ),

            // ElevatedButton(
            //   onPressed: () async {
            //     Map<Permission, PermissionStatus> statuses = await [
            //       Permission.storage,
            //       Permission.camera,
            //     ].request();
            //     if (statuses[Permission.storage]!.isGranted &&
            //         statuses[Permission.camera]!.isGranted) {
            //       showImagePicker(context);
            //     } else {
            //       print('no permission provided');
            //     }
            //   },
            //   child: const Text('Select Image'),
            // ),
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: const Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        setState(() {
          imageFile = File(value.path);
        });
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        setState(() {
          imageFile = File(value.path);
        });
      }
    });
  }
}

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   File? _imageFile;
//
//   Future<void> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage =
//     await imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(
//             () {
//           _imageFile = File(pickedImage.path);
//         },
//       );
//     }
//
//     //permission
//
//     // bool hasPermission = await requestGalleryPermission();
//     // if (hasPermission) {
//     //   final imagePicker = ImagePicker();
//     //   final pickedImage =
//     //       await imagePicker.pickImage(source: ImageSource.gallery);
//     //
//     //   if (pickedImage != null) {
//     //     setState(
//     //       () {
//     //         _imageFile = File(pickedImage.path);
//     //       },
//     //     );
//     //   }
//     // } else {
//     //   // Handle the case when permission is not granted
//     //   // ignore: use_build_context_synchronously
//     //   showDialog(
//     //     context: context,
//     //     builder: (context) => AlertDialog(
//     //       title: const Text('Permission Required'),
//     //       content: const Text(
//     //           'Please grant access to the gallery to pick an image.'),
//     //       actions: [
//     //         TextButton(
//     //           child: const Text('OK'),
//     //           onPressed: () => Navigator.of(context).pop(),
//     //         ),
//     //       ],
//     //     ),
//     //   );
//     // }
//   }
//
//   Future<bool> requestGalleryPermission() async {
//     PermissionStatus status = await Permission.camera.request();
//     if (status.isGranted) {
//       status = await Permission.storage.request();
//       return status.isGranted;
//     }
//     return false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 200,
//               height: 200,
//               decoration: const BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//                 // image: DecorationImage(
//                 //   // ignore: unnecessary_null_comparison
//                 //   image: _imageFile != null
//                 //       ? _imageFile.path
//                 //       : const NetworkImage(
//                 //           'https://www.pexels.com/photo/light-city-street-dark-16783095/'),
//                 //   fit: BoxFit.cover,
//                 // ),
//               ),
//               child: _imageFile != null
//                   ? Image.file(_imageFile!)
//                   : const CircularProgressIndicator(),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: const Text('Select Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // // ignore_for_file: use_build_context_synchronously
// //
// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// //
// // class ImagePickerPage extends StatefulWidget {
// //   const ImagePickerPage({super.key});
// //
// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _ImagePickerPageState createState() => _ImagePickerPageState();
// // }
// //
// // class _ImagePickerPageState extends State<ImagePickerPage> {
// //   final picker = ImagePicker();
// //   String imagePath = '';
// //
// //   Future<bool> requestGalleryPermission() async {
// //     PermissionStatus status1 = await Permission.camera.request();
// //     // PermissionStatus status2 = await Permission.manageExternalStorage.request();
// //     print("gallery");
// //     if (status1.isGranted) {
// //       // print("inside");
// //       // status = await Permission.storage.request();
// //       // print(status.isGranted);
// //       return true;
// //     }
// //     return false;
// //   }
// //
// //   // Future<bool> requestGalleryPermission() async {
// //   //   PermissionStatus status = await Permission.camera.request();
// //   //   print("gallery");
// //   //   if (status.isGranted) {
// //   //     // print("inside");
// //   //     // status = await Permission.storage.request();
// //   //     // print(status.isGranted);
// //   //     return status.isGranted;
// //   //   }
// //   //   return false;
// //   // }
// //
// //   Future<void> pickImage() async {
// //     bool hasPermission = await requestGalleryPermission();
// //     if (hasPermission) {
// //       print("hassssssss");
// //       final pickedImage = await picker.pickImage(source: ImageSource.gallery);
// //       if (pickedImage != null) {
// //         setState(() {
// //           imagePath = pickedImage.path;
// //         });
// //       }
// //     } else {
// //       print("nooooooo");
// //       showDialog(
// //         context: context,
// //         builder: (context) => AlertDialog(
// //           title: const Text('Permission Required'),
// //           content: const Text(
// //               'Please grant access to the gallery to pick an image.'),
// //           actions: [
// //             TextButton(
// //               child: const Text('OK'),
// //               onPressed: () => Navigator.of(context).pop(),
// //             ),
// //           ],
// //         ),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Image Picker'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             ElevatedButton(
// //               onPressed: pickImage,
// //               child: const Text('Pick Image'),
// //             ),
// //             const SizedBox(height: 16.0),
// //             imagePath.isNotEmpty
// //                 ? Image.file(
// //                     File(imagePath),
// //                     width: 200.0,
// //                     height: 200.0,
// //                   )
// //                 : const Text('No image selected.'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ImagePage extends StatefulWidget {
//   const ImagePage({Key? key}) : super(key: key);
//
//   @override
//   State<ImagePage> createState() => _ImagePageState();
// }
//
// class _ImagePageState extends State<ImagePage> {
//   File? imageFile;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select & Crop Image'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20.0,
//             ),
//             imageFile == null
//                 ? Image.asset(
//                     "images/pic.png",
//                     height: 300,
//                     width: 300,
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(150.0),
//                     child: Image.file(
//                       imageFile!,
//                       height: 300.0,
//                       width: 300.0,
//                       fit: BoxFit.fill,
//                     )),
//             const SizedBox(
//               height: 20.0,
//             ),
//
//             ElevatedButton(
//               onPressed: () async {
//                 PermissionStatus status = await Permission.camera.request();
//                 if (status.isGranted) {
//                   showImagePicker(context);
//                 } else {
//                   print('no permission provided');
//                 }
//               },
//               child: const Text('Select Image'),
//             ),
//
//             // ElevatedButton(
//             //   onPressed: () async {
//             //     Map<Permission, PermissionStatus> statuses = await [
//             //       Permission.storage,
//             //       Permission.camera,
//             //     ].request();
//             //     if (statuses[Permission.storage]!.isGranted &&
//             //         statuses[Permission.camera]!.isGranted) {
//             //       showImagePicker(context);
//             //     } else {
//             //       print('no permission provided');
//             //     }
//             //   },
//             //   child: const Text('Select Image'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   final picker = ImagePicker();
//
//   void showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (builder) {
//           return Card(
//             child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 5.2,
//                 margin: const EdgeInsets.only(top: 8.0),
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                         child: InkWell(
//                       child: const Column(
//                         children: [
//                           Icon(
//                             Icons.image,
//                             size: 60.0,
//                           ),
//                           SizedBox(height: 12.0),
//                           Text(
//                             "Gallery",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 16, color: Colors.black),
//                           )
//                         ],
//                       ),
//                       onTap: () {
//                         _imgFromGallery();
//                         Navigator.pop(context);
//                       },
//                     )),
//                     Expanded(
//                         child: InkWell(
//                       child: const SizedBox(
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.camera_alt,
//                               size: 60.0,
//                             ),
//                             SizedBox(height: 12.0),
//                             Text(
//                               "Camera",
//                               textAlign: TextAlign.center,
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.black),
//                             )
//                           ],
//                         ),
//                       ),
//                       onTap: () {
//                         _imgFromCamera();
//                         Navigator.pop(context);
//                       },
//                     ))
//                   ],
//                 )),
//           );
//         });
//   }
//
//   _imgFromGallery() async {
//     await picker
//         .pickImage(source: ImageSource.gallery, imageQuality: 50)
//         .then((value) {
//       if (value != null) {
//         setState(() {
//           imageFile = File(value.path);
//         });
//       }
//     });
//   }
//
//   _imgFromCamera() async {
//     await picker
//         .pickImage(source: ImageSource.camera, imageQuality: 50)
//         .then((value) {
//       if (value != null) {
//         setState(() {
//           imageFile = File(value.path);
//         });
//       }
//     });
//   }
// }
//
// //
// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// //
// // class ImagePage extends StatefulWidget {
// //   const ImagePage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<ImagePage> createState() => _ImagePageState();
// // }
// //
// // class _ImagePageState extends State<ImagePage> {
// //   File? imageFile;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Select & Crop Image'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           children: [
// //             const SizedBox(
// //               height: 20.0,
// //             ),
// //             imageFile == null
// //                 ? Image.network(
// //               "https://www.pexels.com/photo/black-and-white-photo-of-clouds-over-mountains-6037981/",
// //               height: 300,
// //               width: 300,
// //             )
// //                 : ClipRRect(
// //                 borderRadius: BorderRadius.circular(150.0),
// //                 child: Image.file(
// //                   imageFile!,
// //                   height: 300.0,
// //                   width: 300.0,
// //                   fit: BoxFit.fill,
// //                 )),
// //             const SizedBox(
// //               height: 20.0,
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 Map<Permission, PermissionStatus> statuses = await [
// //                   Permission.storage,
// //                   Permission.camera,
// //                 ].request();
// //                 if (statuses[Permission.storage]!.isGranted &&
// //                     statuses[Permission.camera]!.isGranted) {
// //                   showImagePicker(context);
// //                 } else {
// //                   print('no permission provided');
// //                 }
// //               },
// //               child: Text('Select Image'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   final picker = ImagePicker();
// //
// //   void showImagePicker(BuildContext context) {
// //     showModalBottomSheet(
// //         context: context,
// //         builder: (builder) {
// //           return Card(
// //             child: Container(
// //                 width: MediaQuery.of(context).size.width,
// //                 height: MediaQuery.of(context).size.height / 5.2,
// //                 margin: const EdgeInsets.only(top: 8.0),
// //                 padding: const EdgeInsets.all(12),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Expanded(
// //                         child: InkWell(
// //                           child: Column(
// //                             children: const [
// //                               Icon(
// //                                 Icons.image,
// //                                 size: 60.0,
// //                               ),
// //                               SizedBox(height: 12.0),
// //                               Text(
// //                                 "Gallery",
// //                                 textAlign: TextAlign.center,
// //                                 style: TextStyle(fontSize: 16, color: Colors.black),
// //                               )
// //                             ],
// //                           ),
// //                           onTap: () {
// //                             _imgFromGallery();
// //                             Navigator.pop(context);
// //                           },
// //                         )),
// //                     Expanded(
// //                         child: InkWell(
// //                           child: SizedBox(
// //                             child: Column(
// //                               children: const [
// //                                 Icon(
// //                                   Icons.camera_alt,
// //                                   size: 60.0,
// //                                 ),
// //                                 SizedBox(height: 12.0),
// //                                 Text(
// //                                   "Camera",
// //                                   textAlign: TextAlign.center,
// //                                   style:
// //                                   TextStyle(fontSize: 16, color: Colors.black),
// //                                 )
// //                               ],
// //                             ),
// //                           ),
// //                           onTap: () {
// //                             _imgFromCamera();
// //                             Navigator.pop(context);
// //                           },
// //                         ))
// //                   ],
// //                 )),
// //           );
// //         });
// //   }
// //
// //   _imgFromGallery() async {
// //     await picker
// //         .pickImage(source: ImageSource.gallery, imageQuality: 50)
// //         .then((value) {
// //       if (value != null) {
// //         setState(() {
// //           imageFile = File(value.path);
// //         });
// //       }
// //     });
// //   }
// //
// //   _imgFromCamera() async {
// //     await picker
// //         .pickImage(source: ImageSource.camera, imageQuality: 50)
// //         .then((value) {
// //       if (value != null) {
// //         setState(() {
// //           imageFile = File(value.path);
// //         });
// //       }
// //     });
// //   }
// //
// // // _cropImage(File imgFile) async {
// // //   final croppedFile = await ImageCropper().cropImage(
// // //       sourcePath: imgFile.path,
// // //       aspectRatioPresets: Platform.isAndroid
// // //           ? [
// // //               CropAspectRatioPreset.square,
// // //               CropAspectRatioPreset.ratio3x2,
// // //               CropAspectRatioPreset.original,
// // //               CropAspectRatioPreset.ratio4x3,
// // //               CropAspectRatioPreset.ratio16x9
// // //             ]
// // //           : [
// // //               CropAspectRatioPreset.original,
// // //               CropAspectRatioPreset.square,
// // //               CropAspectRatioPreset.ratio3x2,
// // //               CropAspectRatioPreset.ratio4x3,
// // //               CropAspectRatioPreset.ratio5x3,
// // //               CropAspectRatioPreset.ratio5x4,
// // //               CropAspectRatioPreset.ratio7x5,
// // //               CropAspectRatioPreset.ratio16x9
// // //             ],
// // //       uiSettings: [
// // //         AndroidUiSettings(
// // //             toolbarTitle: "Image Cropper",
// // //             toolbarColor: Colors.deepOrange,
// // //             toolbarWidgetColor: Colors.white,
// // //             initAspectRatio: CropAspectRatioPreset.original,
// // //             lockAspectRatio: false),
// // //         IOSUiSettings(
// // //           title: "Image Cropper",
// // //         )
// // //       ]);
// // //   if (croppedFile != null) {
// // //     imageCache.clear();
// // //     setState(() {
// // //       imageFile = File(croppedFile.path);
// // //     });
// // //     // reload();
// // //   }
// // // }
// // }
