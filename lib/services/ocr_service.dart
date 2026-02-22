import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

/// Service for OCR (Optical Character Recognition) operations
class OCRService {
  final TextRecognizer _textRecognizer;
  final ImagePicker _imagePicker;

  OCRService({
    TextRecognizer? textRecognizer,
    ImagePicker? imagePicker,
  })  : _textRecognizer = textRecognizer ?? GoogleMlKit.vision.textRecognizer(),
        _imagePicker = imagePicker ?? ImagePicker();

  /// Pick an image from gallery
  Future<File?> pickImageFromGallery() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  /// Pick an image from camera
  Future<File?> pickImageFromCamera() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  /// Extract text from an image file
  Future<String> extractTextFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
    
    return recognizedText.text;
  }

  /// Parse receipt data from extracted text
  Map<String, dynamic> parseReceiptData(String text) {
    final lines = text.split('\n');
    final items = <Map<String, dynamic>>[];
    double total = 0.0;

    // More specific pattern for prices - requires decimal point or currency symbol
    for (final line in lines) {
      // Look for price patterns with currency symbol or decimal format
      final priceMatch = RegExp(r'(?:\$|USD|€|£)?\s*(\d+\.\d{2})\b').firstMatch(line);
      if (priceMatch != null) {
        final price = double.tryParse(priceMatch.group(1) ?? '0');
        if (price != null && price > 0) {
          items.add({
            'description': line.replaceAll(priceMatch.group(0)!, '').trim(),
            'amount': price,
          });
          total += price;
        }
      }
    }

    return {
      'items': items,
      'total': total,
      'rawText': text,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Clean up resources
  void dispose() {
    _textRecognizer.close();
  }
}
