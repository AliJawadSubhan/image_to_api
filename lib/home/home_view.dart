import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:send_image_to_api/home/home_viewModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: image == null
                  ? TextButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: Text(data),
                    )
                  : Image.file(
                      File(
                        image!.path,
                      ),
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
            ),
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    sendImagetoApi();
                    log('upload tapped');
                  },
                  child: Text('Upload the data'),
                ),
              )
          ],
        ),
      ),
    );
  }
}
