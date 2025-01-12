import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificatePreview extends StatefulWidget {
  final String pdfPath;

  const CertificatePreview({super.key, required this.pdfPath});

  @override
  State<CertificatePreview> createState() => _CertificatePreviewState();
}

class _CertificatePreviewState extends State<CertificatePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () async {
              if (await canLaunchUrl(Uri.parse(widget.pdfPath))) {
                await launchUrl(Uri.parse(widget.pdfPath));
              } else {
                // Handle the case where the URL cannot be launched
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Could not open PDF in external browser.'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
