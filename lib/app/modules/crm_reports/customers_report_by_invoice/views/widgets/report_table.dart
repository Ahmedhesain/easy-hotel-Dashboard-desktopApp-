import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../data/model/crm_reports/dto/response/customers_report_by_invoice_response.dart';
import '../../controllers/customer_report_by_invoice_controller.dart';

class CustomersReportByInvoiceTable extends GetView<CustomersReportByInvoiceController> {
  const CustomersReportByInvoiceTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Card(
          color: AppColors.backGround,
          child: Container(
              height: size.height * 0.5,
              width: size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                child: Obx(() {
                  return PaginatedDataTable(
                    horizontalMargin: 20,
                    checkboxHorizontalMargin: 20,
                    showCheckboxColumn: true,
                    columns:  [
                      DataColumn(
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.15,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              child: Center(
                                  child: TextWidget(
                                    "رقم الفاتورة",
                                    textAlign: TextAlign.center ,
                                    size: 15,
                                    weight: FontWeight.bold,
                                  )),
                            ),
                          )),

                      DataColumn(
                          onSort: (int ,bool) => controller.onSort(bool, int) ,
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child:  Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const TextWidget(
                                      "تاريخ الفاتورة",
                                      textAlign: TextAlign.center,
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                    controller.sortIndex.value == 1 ?
                                    const Icon(Icons.arrow_downward) : const SizedBox.shrink()
                                  ],
                                )),
                          )),
                      DataColumn(
                          onSort: (int ,bool) => controller.onSort(bool, int) ,
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children:  [
                                       TextWidget(
                                       controller.reportType.value == 1 ? "قيمة الفواتير" :   "قيمة الفاتورة",
                                        textAlign: TextAlign.center,
                                        size: 15,
                                        weight: FontWeight.bold,
                                      ),
                                      controller.sortIndex.value == 2 ?
                                      const Icon(Icons.arrow_downward) : const SizedBox.shrink()
                                    ],
                                  )),
                            ),
                          )),
                      DataColumn(
                          onSort: (int ,bool) => controller.onSort(bool, int) ,
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child:  Padding(
                              padding:const EdgeInsets.symmetric(horizontal: 7),
                              child: Center(
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const TextWidget(
                                        "عدد الثياب",
                                        textAlign: TextAlign.center,
                                        size: 15,
                                        weight: FontWeight.bold,
                                      ),
                                      controller.sortIndex.value == 3  ?
                                      const Icon(Icons.arrow_downward) : const SizedBox.shrink()
                                    ],
                                  )),
                            ),
                          )),
                      DataColumn(
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              child: Center(
                                  child: TextWidget(
                                    "كود العميل",
                                    textAlign: TextAlign.center,
                                    size: 15,
                                    weight: FontWeight.bold,
                                  )),
                            ),
                          )),
                      DataColumn(
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              child: Center(
                                  child: TextWidget(
                                    "اسم العميل",
                                    textAlign: TextAlign.center,
                                    size: 15,
                                    weight: FontWeight.bold,
                                  )),
                            ),
                          )),
                      DataColumn(
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              child: Center(
                                  child: TextWidget(
                                    "هاتف العميل",
                                    textAlign: TextAlign.center,
                                    size: 15,
                                    weight: FontWeight.bold,
                                  )),
                            ),
                          )),
                      DataColumn(
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              child: Center(
                                  child: TextWidget(
                                    "اسم المعرض",
                                    textAlign: TextAlign.center,
                                    size: 15,
                                    weight: FontWeight.bold,
                                  )),
                            ),
                          )),
                    ],
                    source: MyData(
                        data :controller.reportList.value ,
                        selectable: false,
                    ),
                    rowsPerPage: 6,
                    columnSpacing: 0,
                  );
                }),
              )
            // }),
          )),
    );
  }
}


class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.text, required this.index});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return SizedBox(
      height: 30,
      width: size.width * 0.13,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Center(
          child: TextWidget(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            size: 15,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// The "soruce" of the table
class MyData extends DataTableSource {
  MyData({required this.data , this.selectedRow , this.selectable , this.onSelectChanged , this.isSelected});

  final List<CustomersReportByInvoiceResponse> data;

  Function(int)?  voidCallbackAction ;
  Function(bool , int)? onSelectChanged ;
  int? selectedRow ;
  bool Function(int)? isSelected;
  int? rowsCount ;
  bool? selectable ;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
      color: isSelected != null && isSelected!(index) == true ? MaterialStateProperty.all(Colors.blue[100]) :  index.isEven ? MaterialStateProperty.all(AppColors.backGround) :MaterialStateProperty.all( AppColors.appGreyLight),
      cells: [
      DataCell(
          RowWidget(text: data[index].invoiceSerial?.toString() ?? "", index: index)),
      DataCell(RowWidget(text: data[index].invoiceDate != null ? intl.DateFormat("yyyy/MM/dd").format(data[index].invoiceDate!) : "" , index: index)),
      DataCell(
        RowWidget(text: data[index].invoiceValue?.toString() ?? "", index: index),
      ),
      DataCell(
          RowWidget(
              text: data[index].thobeNumber?.toString() ?? "",
              index: index)),
        DataCell(
          RowWidget(
              text: data[index].customerCode ?? "",
              index: index)),
        DataCell(
          RowWidget(
              text: data[index].customerName ?? "",
              index: index)),
        DataCell(
          RowWidget(
              text: data[index].customerMobile?.toString() ?? "",
              index: index)),
        DataCell(
          RowWidget(
              text: data[index].InventoryName ?? "",
              index: index)),
    ],
        onSelectChanged: selectable! ? (value) =>  onSelectChanged!(value! ,index) : null ,
        selected: (isSelected != null && isSelected!(index)) || selectedRow == index,
    );
  }

}
