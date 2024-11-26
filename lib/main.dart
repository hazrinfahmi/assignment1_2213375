//MUHAMAD HAZRIN FAHMI BIN ABD HALIM 2213375
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromRGBO(138, 187, 255, 1),
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  File? _image;
  String? _name;
  int? _age;
  String _nameError = '';
  String _ageError = '';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _submitProfile() {
    setState(() {
      _nameError = '';
      _ageError = '';
      _name = _nameController.text;
      _age = int.tryParse(_ageController.text);

      if (_name == null || _name!.isEmpty || _name!.contains(RegExp(r'[0-9]'))) {
        _nameError = 'Invalid input. Please enter a valid name';
      }
      if (_age == null) {
        _ageError = 'Invalid input. Please enter a valid age';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SIMPLE PROFILE PAGE', style: TextStyle(fontWeight: FontWeight.bold))),
        backgroundColor: const Color.fromRGBO(138, 187, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(color: Colors.black), 
                  errorText: _nameError.isNotEmpty ? _nameError : null,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), 
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0), 
                  ),
                  filled: true, 
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: const TextStyle(color: Colors.black),
                  errorText: _ageError.isNotEmpty ? _ageError : null,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), 
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0), 
                  ),
                  filled: true, 
                  fillColor: Colors.white, 
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Upload Profile Picture'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color.fromARGB(255, 1, 102, 210),
                  foregroundColor: Colors.white, 
                  elevation: 10,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitProfile,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color.fromARGB(255, 1, 102, 210),
                  foregroundColor: Colors.white, 
                  elevation: 10,
                ),
              ),
              const SizedBox(height: 20),
              if (_name != null && _age != null && _nameError.isEmpty && _ageError.isEmpty)
                Column(
                  children: [
                    ClipOval(
                      child: _image != null
                          ? Image.file(
                              _image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/default_profile.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Name: $_name',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Age: $_age',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}