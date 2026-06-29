import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileScannerSimple extends StatefulWidget {
  /// Constructor for simple Mobile Scanner example
  const MobileScannerSimple({super.key});

  @override
  State<MobileScannerSimple> createState() => _MobileScannerSimpleState();
}

class _MobileScannerSimpleState extends State<MobileScannerSimple> {
  Barcode? _barcode;
  final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(center: MediaQuery.sizeOf(context).center(Offset.zero) , width: 200, height: 200);
    return Scaffold(
      appBar: AppBar(title: const Text('Scan a RealBirth QR')),
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: MobileScanner(
              onDetect: _handleBarcode,
              fit: BoxFit.contain,
              controller: controller,
              scanWindow: scanWindow,
              overlayBuilder: (context, constraints){
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                  )
                );
              },
            ),
          ),
          ValueListenableBuilder(valueListenable: controller, builder: (context, value, child){
            if(!value.isInitialized || !value.isRunning || value.error != null){
              return const SizedBox();
            }
            return ScanWindowOverlay(scanWindow: scanWindow, controller: controller);},
            )
          ])
        ,
      );
  }

    void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
        _launchURL(_barcode);
      });
    }
  }
  _launchURL(Barcode) async {
   final Uri _url = Uri.parse(Barcode.rawValue);
   if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
    }
  }
}