import 'package:mobx/mobx.dart';
part 'service_controller.g.dart';

class ServiceController = ServiceControllerBase with _$ServiceController;
abstract class ServiceControllerBase with Store{
  @observable
  int numeroDeClicks = 0;
  
  @action
  addClick(){
    numeroDeClicks++;
  }
}