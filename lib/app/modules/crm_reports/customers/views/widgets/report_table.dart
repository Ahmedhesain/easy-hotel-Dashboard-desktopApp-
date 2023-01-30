import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/table.dart';

import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../data/model/crm_reports/dto/response/customers_report_response.dart';
import '../../controllers/customers_controller.dart';

class CustomersReportTable extends GetView<CustomersController> {
  const CustomersReportTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
      child: Card(
          color: AppColors.backGround,
          child: Container(
              height: size.height * 0.65,
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
                                    "اسم العميل",
                                    textAlign: TextAlign.center ,
                                    size: 15,
                                    weight: FontWeight.bold,
                                  )),
                            ),
                          )),

                      DataColumn(
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child: const Center(
                                child: TextWidget(
                                  "كود العميل",
                                  textAlign: TextAlign.center,
                                  size: 15,
                                  weight: FontWeight.bold,
                                )),
                          )),
                      DataColumn(
                          label: SizedBox(
                            height: 30,
                            width: size.width * 0.13,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              child: Center(
                                  child: TextWidget(
                                    "رقم الهاتف",
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
                                    "حالة العميل",
                                    textAlign: TextAlign.center,
                                    size: 15,
                                    weight: FontWeight.bold,
                                  )),
                            ),
                          )),
                    ],
                    source: MyData(
                        data :controller.reportList.value ,
                        onSelectChanged: (selected , index) => controller.onSelect(selected, controller.reportList[index]),
                        selectable: true,
                        isSelected : (index) => controller.selectedReportList.contains(controller.reportList[index])
                    ),
                    rowsPerPage: 8,
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
        padding: EdgeInsets.symmetric(horizontal: 7),
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

  final List<CustomersReportResponse> data;

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
          RowWidget(text: data[index].clientName, index: index)),
      DataCell(RowWidget(text: data[index].clientCode, index: index)),
      DataCell(
        RowWidget(text: data[index].clientMobile, index: index),
      ),
      DataCell(
          RowWidget(
              text: data[index].black != null && data[index].black == 1 ? "محظور" : "غير محظور",
              index: index)),
    ],
        onSelectChanged: selectable! ? (value) =>  onSelectChanged!(value! ,index) : null ,
        selected: (isSelected != null && isSelected!(index)) || selectedRow == index,
    );
  }

}
