import 'package:get/get.dart';
import 'package:toby_bills/app/modules/production_stages/controllers/production_stages_controller.dart';


class ProductionStagesBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<ProductionStagesController>(() => ProductionStagesController());
  }

}
