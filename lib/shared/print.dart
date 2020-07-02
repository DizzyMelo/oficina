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

  static print(ServiceModel service, List<ProdutosAdicionado> items) async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            title('Cliente', service.nomeCliente ?? 'Não informado'),
            title('Colaborador', service.nomeColaborador ?? 'Não informado'),
            title(
                'Data Inicio',
                service.dataInicio == null || service.dataInicio.isEmpty
                    ? 'Não informado'
                    : Utils.formatDate(DateTime.parse(service.dataInicio))),
            title(
                'Data Final',
                service.dataFinal == null || service.dataFinal.isEmpty
                    ? 'Não informado'
                    : Utils.formatDate(DateTime.parse(service.dataFinal))),
            pw.SizedBox(height: 10),
            pw.Expanded(
              child: pw.ListView.builder(
                  itemBuilder: (context, index) {
                    ProdutosAdicionado item = items[index];
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
                                    pw.Text(item.nome ?? 'Não informado'),
                                    pw.Text(
                                        '${item.qtd} X ${Utils.formatMoney(double.parse(item.valorVenda))}'),
                                  ]),
                              pw.Text(Utils.formatMoney(
                                      double.parse(item.valorTotal)) ??
                                  'Não informado')
                            ]));
                  },
                  itemCount: items.length),
            ),
            bottom('Garantia', '${service.garantia} meses'),
            bottom(
                'Desconto', Utils.formatMoney(double.parse(service.desconto))),
            bottom('Mão de Obra', Utils.formatMoney(double.parse(service.mdo))),
            bottom(
                'Total', Utils.formatMoney(double.parse(service.valorTotal))),
          ]); // Center
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
