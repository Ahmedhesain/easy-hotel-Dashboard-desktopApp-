import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/data/model/gallery_expenses/dto/GalleryExpensesDTO.dart';
import '../../../../components/content_dialog.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/daily_expenses_search_controller.dart';
import 'package:intl/intl.dart'as intl;
class DailyExpensesTableWidget extends GetView<DailyExpensesSearchController> {
  const DailyExpensesTableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Card(
        color: AppColors.backGround,
        child: Container(
            height: size.height * 0.6,
            width: size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: SingleChildScrollView(
              child: Obx(() {
                return PaginatedDataTable(
                  columns: [
                    DataColumn(
                        label: SizedBox(
                          height: 30,
                          width: size.width * 0.1,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Center(
                                child: TextWidget(
                                  "م",
                                  textAlign: TextAlign.center,
                                  size: 15,
                                  weight: FontWeight.bold,
                                )),
                          ),
                        )),
                    DataColumn(
                        label: SizedBox(
                          height: 30,
                          width: size.width * 0.1,
                          child: const Center(
                              child: TextWidget(
                                "منصرف",
                                textAlign: TextAlign.center,
                                size: 15,
                                weight: FontWeight.bold,
                              )),
                        )),
                    DataColumn(
                        label: SizedBox(
                          height: 30,
                          width: size.width * 0.3,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Center(
                                child: TextWidget(
                                  "بيان",
                                  textAlign: TextAlign.center,
                                  size: 15,
                                  weight: FontWeight.bold,
                                )),
                          ),
                        )),
                    DataColumn(
                        label: SizedBox(
                          height: 30,
                          width: size.width * 0.1,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Center(
                                child: TextWidget(
                                  "التاريخ",
                                  textAlign: TextAlign.center,
                                  size: 15,
                                  weight: FontWeight.bold,
                                )),
                          ),
                        )),
                    DataColumn(
                        label: SizedBox(
                          height: 30,
                          width: size.width * 0.1,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Center(
                                child: TextWidget(
                                  "الحركة",
                                  textAlign: TextAlign.center,
                                  size: 15,
                                  weight: FontWeight.bold,
                                )),
                          ),
                        )),
                  ],
                  source: ExpensesTableSource(
                      data: controller.reportList,
                      total: controller.total.value,
                      size: size,
                      onDelete: controller.delete),
                  rowsPerPage: 10,
                  columnSpacing: 10,
                );
              }),
            )));
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({super.key,
    required this.text,
    required this.index,
    required this.width});

  final int index;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: width,
      child: Text(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// The "soruce" of the table
class ExpensesTableSource extends DataTableSource {
  ExpensesTableSource({required this.data,
    this.selectedRow,
    this.selectable,
    this.onSelectChanged,
    this.isSelected,
    this.onDelete,
    this.total,
    required this.size});

  final List<GalleryExpensesDTO> data;
  Function(int)? voidCallbackAction;

  Function(int)? onDelete;

  Function(bool, int)? onSelectChanged;

  int? selectedRow;
  double? total;

  bool Function(int)? isSelected;
  int? rowsCount;

  bool? selectable;

  final Size size;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length + 1;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return index == data.length ?
    DataRow(
      color: isSelected != null && isSelected!(index) == true
          ? MaterialStateProperty.all(Colors.blue[100])
          : index.isEven
          ? MaterialStateProperty.all(AppColors.backGround)
          : MaterialStateProperty.all(AppColors.appGreyLight),
      cells: [
        DataCell(RowWidget(
          text: "",
          index: index,
          width: size.width * 0.1,
        )),
        DataCell(RowWidget(
          text: total?.toString() ?? "",
          index: index,
          width: size.width * 0.1,
        )),
        DataCell(
          RowWidget(
            text: "الاجمالي",
            index: index,
            width: size.width * 0.3,
          ),
        ),
        DataCell(
          RowWidget(
            text: "",
            index: index,
            width: size.width * 0.1,
          ),),        DataCell(
          RowWidget(
            text: "",
            index: index,
            width: size.width * 0.3,
          ),),
      ],
      onSelectChanged: selectable != null && selectable!
          ? (value) => onSelectChanged!(value!, index)
          : null,
      selected:
      (isSelected != null && isSelected!(index)) || selectedRow == index,
    ) :
    DataRow(
      color: isSelected != null && isSelected!(index) == true
          ? MaterialStateProperty.all(Colors.blue[100])
          : index.isEven
          ? MaterialStateProperty.all(AppColors.backGround)
          : MaterialStateProperty.all(AppColors.appGreyLight),
      cells: [
        DataCell(RowWidget(
          text: (index + 1).toString(),
          index: index,
          width: size.width * 0.1,
        )),
        DataCell(RowWidget(
          text: data[index].value?.toString() ?? "",
          index: index,
          width: size.width * 0.1,
        )),
        DataCell(
          RowWidget(
            text: data[index].remarks ?? "",
            index: index,
            width: size.width * 0.3,
          ),
        ),
        DataCell(
          RowWidget(
            text: data[index].createdDate != null ? intl.DateFormat("yyyy:MM:dd").format(data[index].createdDate!) : "",
            index: index,
            width: size.width * 0.1,
          ),
        ),
        DataCell(SizedBox(
          width: size.width * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                text: "تعديل",
                onPressed: () => Get.toNamed(Routes.DAILYEXPENSES , arguments: data[index]),
              ),
              ButtonWidget(
                  text: "حذف",
                  buttonColor: Colors.redAccent,
                  onPressed: () =>
                      Get.dialog(
                        ContentDialog(
                          title: const TextWidget(
                            "تأكيد",
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                          content: const TextWidget(
                            "هل تريد حذف هذا العنصر؟",
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                          actions: [
                            ButtonWidget(
                              text: "نعم",
                              onPressed: () {
                                Get.back();
                                onDelete!(data[index].id!);
                              },
                              buttonColor: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ButtonWidget(
                                text: "لا", onPressed: () => Get.back()),
                          ],
                        ),
                      )),
            ],
          ),
        )),
      ],
      onSelectChanged: selectable != null && selectable!
          ? (value) => onSelectChanged!(value!, index)
          : null,
      selected:
      (isSelected != null && isSelected!(index)) || selectedRow == index,
    );
  }
}
