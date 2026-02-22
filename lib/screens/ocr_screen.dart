import 'dart:io';
import 'package:flutter/material.dart';
import '../services/ocr_service.dart';

/// Screen for OCR (receipt scanning)
class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  final _ocrService = OCRService();
  File? _imageFile;
  String? _extractedText;
  Map<String, dynamic>? _parsedData;
  bool _isProcessing = false;

  Future<void> _pickImageFromGallery() async {
    setState(() {
      _isProcessing = true;
      _extractedText = null;
      _parsedData = null;
    });

    try {
      final image = await _ocrService.pickImageFromGallery();
      if (image != null) {
        setState(() {
          _imageFile = image;
        });
        await _processImage(image);
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    setState(() {
      _isProcessing = true;
      _extractedText = null;
      _parsedData = null;
    });

    try {
      final image = await _ocrService.pickImageFromCamera();
      if (image != null) {
        setState(() {
          _imageFile = image;
        });
        await _processImage(image);
      }
    } catch (e) {
      _showError('Failed to capture image: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _processImage(File image) async {
    try {
      final text = await _ocrService.extractTextFromImage(image);
      final parsed = _ocrService.parseReceiptData(text);

      setState(() {
        _extractedText = text;
        _parsedData = parsed;
      });
    } catch (e) {
      _showError('Failed to process image: $e');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Receipt'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Choose an option to scan receipt',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _isProcessing ? null : _pickImageFromCamera,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Camera'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _isProcessing ? null : _pickImageFromGallery,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Gallery'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isProcessing) ...[
            const SizedBox(height: 24),
            const Center(
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text('Processing image...'),
            ),
          ],
          if (_imageFile != null && !_isProcessing) ...[
            const SizedBox(height: 24),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.file(_imageFile!, height: 300, fit: BoxFit.cover),
                  if (_extractedText != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Extracted Text:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(_extractedText!),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (_parsedData != null) ...[
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parsed Data:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text('Total: \$${_parsedData!['total']}'),
                    const SizedBox(height: 8),
                    Text('Items: ${(_parsedData!['items'] as List).length}'),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to add sale with pre-filled data
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Create Sale from Data'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
