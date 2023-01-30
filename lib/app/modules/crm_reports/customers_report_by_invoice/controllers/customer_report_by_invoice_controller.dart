


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersReportByInvoiceController extends GetxController {
  final isLoading = false.obs;
  final invoiceValueFrom = TextEditingController();
  final invoiceValueTo = TextEditingController();
  final invoiceNumberFrom = TextEditingController();
  final invoiceNumberTo = TextEditingController();
  Rxn<DateTime> invoiceDateFrom = Rxn();
  Rxn<DateTime> invoiceDateTo = Rxn();
}