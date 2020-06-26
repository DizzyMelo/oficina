import 'package:flutter/material.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/shared/style.dart';

class WorkerRowComponent extends StatelessWidget {
  final WorkerModel workerModel;
  WorkerRowComponent(this.workerModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workerModel.nome.toUpperCase(),
                        style: Style.mainClientNameText,
                      ),
                      Text(
                        workerModel.funcao ?? 'vazio',
                        style: Style.carNameText,
                      ),
                    ]),
              )),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        workerModel.telefone,
                        style: Style.phoneText,
                      ),
                    ]),
              )),
          // Flexible(
          //     flex: 1,
          //     child: Container(
          //       width: double.infinity,
          //       child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             Text(
          //               serviceModel.nomeColaborador.toUpperCase(),
          //               style: Style.workerNameText,
          //             ),
          //           ]),
          //     )),
        ],
      ),
    );
  }
}
