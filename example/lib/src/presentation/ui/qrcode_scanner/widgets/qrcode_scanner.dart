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
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;
  bool _resultFound = false;
  CustomPaint? _customPaint;
  String? _text;

  List<CameraDescription>? cameras;

  @override
  void dispose() {
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: availableCameras(),
        builder: (
          context,
          AsyncSnapshot<List<CameraDescription>> snapshot,
        ) {
          if (snapshot.hasData) {
            cameras = snapshot.data;
            return CameraView(
              cameras: cameras!,
              onImage: (inputImage) {
                processImage(inputImage);
              },
              customPaint: _customPaint,
              title: 'Scan QR Code',
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      //body: _buildBody(),
    );
  }

  ///
  Widget _buildBody() {
    return Stack(
      children: [
        _buildQrView(),
        _buildQrCodeScanOverlay(),
        _buildClosePageElement(),
      ],
    );
  }

  ///
  Widget _buildQrView() {
    return const SizedBox.shrink();
    /*return MobileScanner(
      controller: MobileScannerController(
        formats: const [BarcodeFormat.qrCode],
      ),
      onDetect: (barcode) {
        _resultCallback(barcode.barcodes.first.rawValue);
      },
    );*/
  }

  ///
  Widget _buildClosePageElement() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(right: 15),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: CustomButtonStyle.iconButtonStyle,
            child: const Icon(
              Icons.close,
              color: CustomColors.secondaryButton,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget _buildQrCodeScanOverlay() {
    double cutOutSize = MediaQuery.of(context).size.width * 0.85;
    return Container(
      decoration: ShapeDecoration(
        shape: QrScannerOverlayShape(
          borderColor: CustomColors.primaryButton,
          borderWidth: 5,
          cutOutSize: cutOutSize,
        ),
      ),
    );
  }

  ///
  void _resultCallback(String? rawValue) {
    _resultFound = true;
    _barcodeScanner.close();
    Navigator.pop(context, rawValue);
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final barcodes = await _barcodeScanner.processImage(inputImage);

    if (barcodes.isEmpty) {
      _isBusy = false;
      return;
    }
    /*if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainter(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {*/
    String text = 'Barcodes found: ${barcodes.length}\n\n';

    if (_resultFound) {
      return;
    }

    _resultCallback(barcodes.first.rawValue);



    for (final barcode in barcodes) {
      text += 'Barcode: ${barcode.rawValue}\n\n';
    }
    _text = text;
    // TODO: set _customPaint to draw boundingRect on top of image
    _customPaint = null;
    //}
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  ///
  Future<void> _initCameras() async {
    cameras = await availableCameras();
    setState(() {});
  }
}
