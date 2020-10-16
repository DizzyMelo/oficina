import 'package:oficina/model/detail_service_data_model.dart';
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

  static print(DetailServiceDataModel service) async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            title(
                'Cliente',
                service.data.data.client != null
                    ? service.data.data.client.name
                    : 'Não informado'),
            title(
                'Colaborador',
                service.data.data.colaborator != null
                    ? service.data.data.colaborator.name
                    : 'Não informado'),
            title(
                'Data Inicio',
                service.data.data.date != null
                    ? Utils.formatDate(service.data.data.date)
                    : 'Não informado'),
            title(
                'Data Final',
                service.data.data.dateEnd != null
                    ? Utils.formatDate(service.data.data.dateEnd)
                    : 'Não informado'),
            pw.SizedBox(height: 10),
            pw.Text('PRODUTOS ADICIONADOS'),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Expanded(
              child: pw.ListView.builder(
                  itemBuilder: (context, index) {
                    AddedProduct product =
                        service.data.data.addedProducts[index];
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
                                    pw.Text(product.product.name),
                                    pw.Text(
                                        '${product.amount} X ${Utils.formatMoney(product.product.priceSale)}'),
                                  ]),
                              pw.Text(Utils.formatMoney(product.totalPrice) ??
                                  'Não informado')
                            ]));
                  },
                  itemCount: service.data.data.addedProducts.length),
            ),
            pw.Divider(),
            bottom('Garantia',
                '${service.data.data.warranty} ${service.data.data.warrantyUnity}'),
            bottom('Desconto', Utils.formatMoney(service.data.data.discount)),
            bottom('Mão de Obra', Utils.formatMoney(service.data.data.how)),
            bottom('Total', Utils.formatMoney(service.data.data.value)),
          ]); // Center
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
