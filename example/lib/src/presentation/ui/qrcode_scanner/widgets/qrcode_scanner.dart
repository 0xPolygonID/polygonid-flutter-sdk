import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/qrcode_scanner/widgets/barcode_detector_painter.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/qrcode_scanner/widgets/camera_view.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/qrcode_scanner/widgets/qrcode_scanner_overlay_shape.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({Key? key}) : super(key: key);

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final BarcodeScanner _barcodeScanner =
      BarcodeScanner(formats: [BarcodeFormat.qrCode]);

  bool _canProcess = true;
  bool _isBusy = false;
  bool _resultFound = false;
  CustomPaint? _customPaint;

  @override
  void dispose() {
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  ///
  Widget _buildBody() {
    return FutureBuilder(
      future: availableCameras(),
      builder: (
        context,
        AsyncSnapshot<List<CameraDescription>> snapshot,
      ) {
        if (snapshot.hasData) {
          snapshot.data;
          return CameraView(
            cameras: snapshot.data!,
            onImage: (inputImage) {
              processImage(inputImage);
            },
            onQrCodeScanned: (code) {
              _resultCallback(code);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ///
  void _resultCallback(String? rawValue) {
    _resultFound = true;
    _barcodeScanner.close();
    Navigator.pop(context, rawValue);
  }

  ///
  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final barcodes = await _barcodeScanner.processImage(inputImage);

    if (barcodes.isEmpty) {
      _isBusy = false;
      return;
    }

    // To avoid multiple scans of the same barcode
    if (_resultFound) {
      return;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }

    _resultCallback(barcodes.first.rawValue);
  }
}
