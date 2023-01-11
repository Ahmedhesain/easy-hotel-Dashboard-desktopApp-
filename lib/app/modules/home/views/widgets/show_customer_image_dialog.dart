


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

class ShowCustomerImageDialog extends GetView<HomeController> {
  const ShowCustomerImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Dialog(
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.8,
        child: Image.network(ApiProvider.apiUrlImage + controller.selectedCustomer.value!.imgMeasure! , fit: BoxFit.cover,)),
    );
  }

}