/*
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificatePreview extends StatefulWidget {
  final String pdfPath;

  const CertificatePreview({super.key, required this.pdfPath});

  @override
  State<CertificatePreview> createState() => _CertificatePreviewState();
}

class _CertificatePreviewState extends State<CertificatePreview> {
  double _progress = 0.0;
  bool fileDownloaded = false;
  String? filepath;

  Future<void> downloadPdf() async {
    final url = widget.pdfPath; // Replace with your PDF URL
    try {
      // Get the app's document directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/certificate.pdf';

      // Use Dio to download the file
      final dio = Dio();
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            print('Download progress: $progress%');

            // Update progress in the UI
            setState(() {
              _progress = received / total;
              if (_progress == 1) {
                fileDownloaded = true;
                filepath = filePath;
              }
            });
          }
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File downloaded to $filePath'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () {
              OpenFile.open(filePath);
            },
          ),
        ),
      );

      print('PDF downloaded successfully: $filePath');
      // Optionally, you can show a snackbar or dialog to notify the user
    } catch (e) {
      print('Error downloading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error downloading PDF.')),
      );
    }
  }

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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _progress == 0
                    ? "assets/images/animations/download/rocket.png"
                    : _progress == 1
                        ? "assets/images/animations/download/fireworks.gif"
                        : "assets/images/animations/download/rocket.gif",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_progress == 0
                        ? "Download haven't started"
                        : _progress == 1
                            ? "Downloaded"
                            : "Downloading.."),
                    Text(
                      "${(_progress * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                          color: TColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(10),
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: TColors.grey,
                  color: TColors.success,
                  minHeight: 10,
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: _progress != 1,
                child: ElevatedButton(
                  onPressed: () async {
                    await downloadPdf();
                  },
                  child: const Text('Download PDF'),
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: _progress == 1,
                child: ElevatedButton(
                  onPressed: () async {
                    Text('File downloaded to $filepath');
                    OpenFile.open(filepath);
                  },
                  child: const Text('Open Certificate'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../utils/constants/colors.dart';

class DownloadProgressDialog extends StatefulWidget {
  final String pdfPath;

  const DownloadProgressDialog({super.key, required this.pdfPath});

  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  double _progress = 0.0;
  bool fileDownloaded = false;
  String? filepath;

  Future<void> downloadPdf() async {
    final url = widget.pdfPath; // Replace with your PDF URL
    try {
      // Get the app's document directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/certificate.pdf';

      // Use Dio to download the file
      final dio = Dio();
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            // print('Download progress: $progress%');

            // Update progress in the UI
            setState(() {
              _progress = received / total;
              if (_progress == 1) {
                fileDownloaded = true;
                filepath = filePath;
              }
            });
          }
        },
      );
      print('PDF downloaded successfully: $filePath');
      // Close the dialog after download is complete
      // Navigator.of(context).pop();

      // Show a snack bar or other notification here
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File downloaded to $filePath'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () {
              OpenFile.open(filePath);
            },
          ),
        ),
      );*/
    } catch (e) {
      print('Error downloading PDF: $e');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error downloading PDF.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Start the download as soon as the dialog is shown
    downloadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      // title: const Text('Downloading Certificate'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            _progress == 0
                ? "assets/images/animations/download/rocket.gif"
                : _progress == 1
                    ? "assets/images/animations/download/fireworks.gif"
                    : "assets/images/animations/download/rocket.gif",
            // width: 100,
            height: 100,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_progress == 0
                    ? "Starting download"
                    : _progress == 1
                        ? "Downloaded"
                        : "Downloading.."),
                Text(
                  "${(_progress * 100).toStringAsFixed(1)}%",
                  style: TextStyle(
                      color: TColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: TColors.grey,
              color: TColors.success,
              minHeight: 10,
            ),
          ),
        ],
      ),
      actions: [
        if (fileDownloaded)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: TColors.secondaryColor),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: TColors.secondaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primaryColor,
                  ),
                  onPressed: () async {
                    OpenFile.open(filepath);
                  },
                  child: const Text(
                    'Open Certificate',
                    style: TextStyle(
                        color: TColors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
