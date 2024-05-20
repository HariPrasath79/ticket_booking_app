import 'dart:io';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// ignore: implementation_imports
import 'package:flutter/src/widgets/text.dart' as nw;
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class EmsPdfService {
  static Future<Uint8List> generateEMSPDF() async {
    var myTheme = pw.ThemeData.withFont(
      base: Font.ttf(
          await rootBundle.load("assets/fonts/popins/Poppins-Regular.ttf")),
    );

    final pdf = pw.Document(
      theme: myTheme,
    );

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(child: pw.Text('Hello there'));
        }));
    return pdf.save();
  }

  static Future<void> savePdfFile(
      String fileName, Uint8List byteList, BuildContext context) async {
    await Permission.storage.request();

    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);

    DocumentFileSavePlus()
        .saveFile(byteList, "$fileName.pdf", "appliation/pdf")
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const nw.Text('File downloaded'),
                action: SnackBarAction(
                    label: 'view',
                    onPressed: () async {
                      await OpenFile.open(filePath);
                    }),
              ),
            ));
  }
}
