import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../services/index.dart';
import '../../widgets/index.dart';

class PDFViewerScreen extends StatelessWidget {
  static const routeName = '/pdf-viewer';

  final String title;
  final String url;

  const PDFViewerScreen({
    required this.title,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('PDF_VIEWER_SCREEN');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(title),
      body: SafeArea(
        child: SfPdfViewer.network(
          url,
          enableDoubleTapZooming: false,
          onDocumentLoadFailed: (_) async => {
            await Analytics.crashEvent(
              'PDFViewerScreen',
              exception: 'Error while loading PDF',
            )
          },
        ),
      ),
    );
  }
}
