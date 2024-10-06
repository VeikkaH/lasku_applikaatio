import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:lasku_applikaatio/part.dart';

class PrintPage extends StatelessWidget {
  final List<Part> parts;
  final String projectName;

  const PrintPage({
    super.key,
    required this.parts,
    required this.projectName,
    });

  
  @override
  
  
  Widget build(BuildContext context) {

    final defaultProjectName = projectName.isEmpty ? '' : projectName;
    final fallbackParts = parts.isEmpty
        ? [Part(partName: '', length: 0, width: 0, depth: 0)]
        : parts;

    return Scaffold(
      body: PdfPreview(
        build: (format) => _generatePdf(format, defaultProjectName, fallbackParts),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String projectName, List<Part> parts) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [ pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                projectName,
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Projektin osien mitat ja poistettavan maan määrä',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: [
                  'Osa',
                  'Pituus (cm\u00B3)',
                  'Leveys (cm\u00B3)',
                  'Syvyys (cm\u00B3)',
                  'Yhteensä (cm\u00B3)',
                ],
                data: parts.map((part) => [
                  part.partName,
                  part.length,
                  part.width,
                  part.depth,
                  (double.parse(part.length.toString()) * double.parse(part.width.toString()) * double.parse(part.depth.toString())),
                ]).toList(),
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerRight,
                  2: pw.Alignment.centerRight,
                  3: pw.Alignment.centerRight,
                  4: pw.Alignment.centerRight,
                }
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      children: [
                        pw.Text('Poistettava yhteensä: ${parts.map((part) => double.parse(part.length.toString()) * double.parse(part.width.toString()) * double.parse(part.depth.toString())).reduce((a, b) => a + b)} cm\u00B3', 
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    )
                  )            
                ]
              )
            ],
          ),
          ];
        },
        footer: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Divider(),
              pw.Text('Maanpoisto Miehet Oy', style: pw.TextStyle(color: PdfColors.grey600)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
  
}