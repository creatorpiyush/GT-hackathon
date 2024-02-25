import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraScannerPage extends StatefulWidget {
  const CameraScannerPage({super.key});

  @override
  State<CameraScannerPage> createState() => _CameraScannerPageState();
}

class _CameraScannerPageState extends State<CameraScannerPage> {
  CameraController? _cameraController;
  String? _recognizedText = "";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _cameraController?.initialize();
    _cameraController?.startImageStream((image) {
      _processImage(image);
    });
    setState(() {});
  }

  Future<void> _processImage(CameraImage image) async {
    final textRecognizer = TextRecognizer();
    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(
        InputImage.fromBytes(
            bytes: image.planes[0].bytes,
            metadata: InputImageMetadata(
              size: Size(image.width as double, image.height as double),
              rotation: InputImageRotation.rotation0deg,
              format: InputImageFormat.nv21,
              bytesPerRow: image.planes[0].bytesPerRow,
            )),
      );
      setState(() => _recognizedText = recognizedText.text);
    } catch (error) {
      print('Error processing image: $error');
      // Handle errors appropriately, e.g., display an error message or retry
    }
  }

  Future<void> _captureImage() async {
    // Capture image and process it here if needed
    // ...
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Scanner'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (_cameraController != null &&
              _cameraController!.value.isInitialized)
            CameraPreview(
              _cameraController!,
              child: Container(
                color: Colors.transparent,
                child: const Center(),
              ),
            ),
          Positioned(
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 3),
                ),
              ),
            ),
          ),
          if (_recognizedText?.isNotEmpty == true)
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                _recognizedText!,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          Positioned(
            bottom: 30,
            right: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              onPressed: () async {
                // Capture image and extract text
                if (_cameraController?.value.isRecordingVideo == false) {
                  try {
                    final image = await _cameraController?.takePicture();
                    if (image != null) {
                      // Process captured image to extract text using ML Kit
                      final textRecognizer = TextRecognizer();
                      final RecognizedText recognizedText =
                          await textRecognizer.processImage(
                        InputImage.fromFilePath(image.path),
                      );
                      setState(() => _recognizedText = recognizedText.text);
                    }
                  } catch (error) {
                    print('Error capturing or processing image: $error');
                    // Handle errors appropriately, e.g., display an error message
                  }
                } else {
                  print('Camera is recording video, cannot capture image');
                  // Handle the case where the camera is recording video
                }
              },
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}
