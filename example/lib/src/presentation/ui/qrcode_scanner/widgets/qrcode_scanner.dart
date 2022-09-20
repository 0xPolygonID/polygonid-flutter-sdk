import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/qrcode_scanner/widgets/qrcode_scanner_overlay_shape.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({Key? key}) : super(key: key);

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
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
    return MobileScanner(
      allowDuplicates: false,
      onDetect: (Barcode barcode, MobileScannerArguments? args) {
        _resultCallback(barcode.rawValue);
      },
    );
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
    Navigator.pop(context, rawValue);
  }
}
