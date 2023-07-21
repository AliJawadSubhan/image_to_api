// ignore: file_names
import 'dart:developer';
import 'dart:io' show File;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart' show State;
import 'package:http/http.dart%20';
import 'package:image_picker/image_picker.dart';
import 'package:send_image_to_api/home/home_view.dart';

abstract class HomeViewModel extends State<Home> {
  String data = 'Upload Image';

  File? image;

  final picker = ImagePicker();

  bool showSpinner = false;

  Future pickImage() async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {
      setState(() {
        data = 'image hasnt been picked';
      });
    }
  }

  sendImagetoApi() async {
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var lengthhh = await image!.length();
    final url = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', url);
    request.fields['title'] = 'This is a static title';
    var multiPort = http.MultipartFile('image', stream, lengthhh);
    request.files.add(multiPort);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      log('sent succesfully');

      var result = String.fromCharCodes(responseData);
      log(result);
    } else {
      setState(() {
        showSpinner = false;
      });
      log('LMFAO DIDNT WORKED');
    }
  }
}
