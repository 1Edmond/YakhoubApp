import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class DoorPhotoScreen extends StatefulWidget {
  final Function(File photo, Position position) onSave;
  
  const DoorPhotoScreen({super.key, required this.onSave});

  @override
  State<DoorPhotoScreen> createState() => _DoorPhotoScreenState();
}

class _DoorPhotoScreenState extends State<DoorPhotoScreen> {
  File? _image;
  Position? _position;
  bool _isLoading = false;

  Future<void> _takePhoto() async {
    setState(() => _isLoading = true);
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      
      if (photo != null) {
        // Location
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          throw Exception('Le service de localisation est désactivé.');
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            throw Exception('Les permissions de localisation sont refusées.');
          }
        }
        
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        
        setState(() {
          _image = File(photo.path);
          _position = position;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo de la porte')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) ...[
              Image.file(_image!, height: 300),
              SizedBox(height: 20),
                            Text('Lat: ${_position?.latitude}, Lng: ${_position?.longitude}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.onSave(_image!, _position!);
                  Navigator.pop(context);
                },
                child: Text('Valider'),
              ),
            ] else ...[
              if (_isLoading) CircularProgressIndicator()
              else ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text('Prendre une photo'),
                onPressed: _takePhoto,
              )
            ]
          ],
        ),
      ),
    );
  }
}
