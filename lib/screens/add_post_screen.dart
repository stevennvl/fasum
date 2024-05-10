import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _textController = TextEditingController();
  late File _image;

  @override
  void initState() {
    super.initState();
    _image = File('');
  }
  final picker = ImagePicker();
  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _savePost() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // A. Image that can be pressed to display the camera to take a photo
            GestureDetector(
              onTap: _getImage,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
                child: _image.path.isNotEmpty
                    ? Image.file(_image)
                    : const Icon(Icons.camera_alt, size: 50),
              ),
            ),
            const SizedBox(height: 20),

            // B. TextField to fill in the post text
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Post text',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePost,
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}