import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';

class LocalProvider {
  GetStorage box = GetStorage("toby_bills");

  static const glAccount = "glAccount";

  saveGlAccounts(List<GlAccountResponse> list){
    final data = list.map((e) => e.toJson()).toList();
    box.write(glAccount, json.encode(data));
  }

  List<GlAccountResponse> getGlAccounts(){
    final data = json.decode(box.read(glAccount)??"[]");
    return GlAccountResponse.fromList(data);
  }

}