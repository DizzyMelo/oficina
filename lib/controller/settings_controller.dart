// import 'package:mobx/mobx.dart';
// import 'package:oficina/model/service_model.dart';
// import 'package:oficina/service/service_service.dart';
// part 'settings_controller.g.dart';

// class SettingsController = SettingsControllerBase with _$SettingsController;
// abstract class SettingsControllerBase with Store{
//   @observable
//   int numeroDeClicks = 0;
  
//   @observable
//   ObservableList<ServiceModel> lista;

//   @action
//   loadServices({id}) async {
//     lista = ObservableList<ServiceModel>.of(await ServiceService.getServices(id));
//   }
  
//   @action
//   addClick(){
//     numeroDeClicks++;
//   }
// }