import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

import '../../../components/table.dart';
import '../controllers/customer_account_statement_controller.dart';

class CustomerAccountStatementView extends GetView<CustomerAccountStatementController> {
  const CustomerAccountStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 0,
            title: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    'المعرض',
                    style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 200,
                  height: 30,
                  margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                    // border: Border.all(color: Colors.grey)
                  ),
                  child: Obx(() {
                    return DropdownSearch<GalleryResponse>(
                      key: UniqueKey(),
                      items: controller.galleries,
                      selectedItem: controller.selectedGallery.value,
                      onChanged: controller.selectedGallery,
                      itemAsString: (gallery) => gallery.name ?? "",
                      dropdownBuilder: (context, g) => Text(g?.name??"",maxLines: 1,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.black, fontSize: 14),),
                      dropdownButtonProps: const DropdownButtonProps(
                          iconSize: 15,
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          constraints: BoxConstraints(minHeight: 10)
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 15),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    'العميل',
                    style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: TypeAheadFormField<FindCustomerResponse>(
                        itemBuilder: (context, client) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(client.name!),
                            ),
                          );
                        },
                        suggestionsCallback: (filter) => controller.customers
                            .where((element) => (element.name ?? "").contains(filter) || (element.code ?? "").contains(filter)),
                        onSuggestionSelected: (value) {
                          controller.customerController.text = value.name ?? "";
                          controller.selectedCustomer(value);
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: controller.customerController,
                          focusNode: controller.customerFocusNode,
                          onSubmitted: (search) => controller.getCustomers(search),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true
                          ),
                        )),
                  ),
                ),
                const Spacer(),
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("بحث"),
                    onPressed: () {
                      controller.getStatements();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("طباعة"),
                    onPressed: () {
                      PrintingHelper().statements(context, controller.reports);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("تصدير الى اكسل"),
                    onPressed: () {
                      ExcelHelper.statementsExcel(controller.reports, context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("رجوع"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          body: TableWidget(
            header: [
              "رقم الفاتورة",
              "التاريخ",
              "عميل",
              "نوع الحركة",
              "رقم فاتورة المبيعات",
              "الخزينة",
              "مدين",
              "دائن",
              "الرصيد",
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text(e),
                    ))
                .toList(),
            headerHeight: 40,
            rows: controller.reports
                .map((e) => [
                      "${e.serial}",
                      (e.date == null ? "" : DateFormat("yyy-MM-dd").format(e.date!)),
                      (e.organizationName),
                      (e.screenName),
                      "${e.invoiceSerial}",
                      "${e.openningBalance}",
                      "${e.adding}",
                      "${e.exitt}",
                      "${e.remarks}"
                    ].map((d) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          d,
                          maxLines: 2,
                        ),
                      );
                    }).toList())
                .toList(),
            minimumCellWidth: 150,
            rowHeight: 50,
          ),
        ),
      );
    });
  }
}
