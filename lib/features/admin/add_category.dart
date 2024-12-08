import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CategoryFormWidget extends StatefulWidget {
  const CategoryFormWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryFormWidgetState createState() => _CategoryFormWidgetState();
}

class _CategoryFormWidgetState extends State<CategoryFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImageAndSaveCategory() async {
    if (_nameController.text.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a name and select an image.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Tải ảnh lên Firebase Storage trong thư mục "laptop"
      final ref = _firebaseStorage
          .ref('laptop/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(_selectedImage!);
      // final imageUrl = await ref.getDownloadURL();

      // Lưu dữ liệu vào Firestore
      // final docRef = await _firestore.collection('categories').add({
      //   'name': _nameController.text,
      //   'image': imageUrl,
      //   'isFeatured': true,
      // });

      if (mounted) {
        // Sau khi lưu, hiển thị SnackBar và reset UI
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category added successfully!')),
        );
        _nameController.clear();
        setState(() {
          _selectedImage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ensure Scaffold is used here
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!, fit: BoxFit.cover)
                      : Icon(Icons.add_a_photo,
                          size: 50, color: Colors.grey[700]),
                ),
              ),
              const SizedBox(height: 16),
              _isUploading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _uploadImageAndSaveCategory,
                      child: const Text('Save Category'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
