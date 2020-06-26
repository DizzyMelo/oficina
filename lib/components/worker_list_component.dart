import 'package:flutter/material.dart';
import 'package:oficina/components/worker_row_component.dart';
import 'package:oficina/model/worker_model.dart';

class WorkerListComponent extends StatelessWidget {
  final List<WorkerModel> workers;

  WorkerListComponent(this.workers);
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView.builder(
            itemExtent: 55,
            itemCount: workers.length,
            itemBuilder: (context, index) {
              WorkerModel worker = workers[index];
              return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ServiceView(
                    //               serviceModel: serviceModel,
                    //             )));
                  },
                  child: WorkerRowComponent(worker));
            }));
  }
}
