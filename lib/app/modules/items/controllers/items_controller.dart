import 'package:get/get.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

class ItemsController extends GetxController {
  final items = RxList<ItemResponse>();


  getItems(String filter) async {
    ItemRepository().getAllItemsLocal(
      onSuccess: (data) {
        items.clear();
        items.addAll(data.where((element) => element.code.toString().contains(filter) || element.name.toString().contains(filter) ).toList());
      }
    );
  }

}
