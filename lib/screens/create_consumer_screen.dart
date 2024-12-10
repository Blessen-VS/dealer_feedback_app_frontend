import 'package:flutter/material.dart';
import '../components/custom_text_field_landing.dart';
import '../components/consumer_rating_component.dart';
import '../components/custom_rounded_component.dart';
import '../components/custom_file_upload_component.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateConsumerPage extends StatefulWidget {
  @override
  _CreateConsumerPageState createState() => _CreateConsumerPageState();
}

class _CreateConsumerPageState extends State<CreateConsumerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  double _rating = 3.0;
  String? _uploadedFile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void submitConsumerDetails() async {
    const url = 'http://localhost:3000/api/create-consumer';

    final data = {
      'name': _nameController.text,
      'email': _emailController.text,
      'contactNumber': _contactNumberController.text,
      'address': {
        'line1': _addressLine1Controller.text,
        'city': _cityController.text,
        'pincode': _pincodeController.text,
      },
      'rating': _rating,
      'document': _uploadedFile, // Send file as base64
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Consumer created successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create consumer')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating consumer: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Consumer'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFieldLanding(
                  controller: _nameController,
                  label: 'Consumer Name',
                ),
                CustomTextFieldLanding(
                  controller: _emailController,
                  label: 'Consumer Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextFieldLanding(
                  controller: _contactNumberController,
                  label: 'Consumer Contact Number',
                  keyboardType: TextInputType.phone,
                ),
                CustomTextFieldLanding(
                  controller: _addressLine1Controller,
                  label: 'Address Line 1',
                ),
                CustomTextFieldLanding(
                  controller: _cityController,
                  label: 'City',
                ),
                CustomTextFieldLanding(
                  controller: _pincodeController,
                  label: 'Pin-code',
                  keyboardType: TextInputType.number,
                ),
                ConsumerRating(
                  rating: _rating,
                  onChanged: (newRating) {
                    setState(() {
                      _rating = newRating;
                    });
                  },
                ),
                FileUploadComponent(
  onFileSelected: (fileContent) {
    setState(() {
      _uploadedFile = fileContent; // Save file as base64 or path (depending on platform)
    });
  },
),
                Center(
                  child: RoundedButton(
                    label: 'Submit',
                    onPressed: submitConsumerDetails,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
