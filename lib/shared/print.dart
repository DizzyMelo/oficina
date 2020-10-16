import 'package:oficina/model/added_item_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/shared/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Printer {
  static pw.Widget title(String title, String value) {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title.toUpperCase(), style: pw.TextStyle(fontSize: 14)),
          pw.Text(value.toUpperCase(), style: pw.TextStyle(fontSize: 14)),
        ]);
  }

  static pw.Widget bottom(String title, String value) {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title),
          pw.Text(value),
        ]);
  }

  static print(ServiceModel serviced, List<ProdutosAdicionado> itemsd) async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            title('Cliente', 'Não informado'),
            title('Colaborador', 'Não informado'),
            title('Data Inicio', 'Não informado'),
            title('Data Final', 'Não informado'),
            pw.SizedBox(height: 10),
            pw.Expanded(
              child: pw.ListView.builder(
                  itemBuilder: (context, index) {
                    return pw.Container(
                        height: 40,
                        width: double.infinity,
                        child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Não informado'),
                                    pw.Text('${10} X ${10}'),
                                  ]),
                              pw.Text(Utils.formatMoney(5) ?? 'Não informado')
                            ]));
                  },
                  itemCount: 5),
            ),
            bottom('Garantia', '${10} meses'),
            bottom('Desconto', Utils.formatMoney(50)),
            bottom('Mão de Obra', Utils.formatMoney(50)),
            bottom('Total', Utils.formatMoney(100)),
          ]); // Center
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
