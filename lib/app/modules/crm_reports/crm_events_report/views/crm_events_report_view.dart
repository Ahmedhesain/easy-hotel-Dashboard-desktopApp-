import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as int;
import 'package:toby_bills/app/components/app_loading_overlay.dart';

import '../../../../components/date_field_widget.dart';
import '../../../../components/table.dart';
import '../../../../components/text_styles.dart';
import '../../../../core/utils/crm_printing_helper.dart';
import '../../../../core/utils/excel_helper_CRM.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../controllers/crm_events_report_controller.dart';

class CrmEventsReportView extends GetView<CrmEventsReportController> {
  const CrmEventsReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        'المعرض',
                        style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: size.width * 0.15,
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
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        const Text('من تاريخ', style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: size.width * .1,
                          child: DateFieldWidget(
                            fillColor: Colors.white,
                            onComplete: (date){
                              controller.dateFrom(date);
                            },
                            date: controller.dateFrom.value,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        const Text('الي تاريخ', style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: size.width * .1,
                          child: DateFieldWidget(
                            fillColor: Colors.white,
                            onComplete: (date){
                              controller.dateTo(date);
                            },
                            date: controller.dateTo.value,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    UnconstrainedBox(
                      child: ElevatedButton(
                        child: const Text("بحث"),
                        onPressed: () => controller.search(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    UnconstrainedBox(
                      child: ElevatedButton(
                        child: const Text("طباعة"),
                        onPressed: () => controller.print(context)
                      ),
                    ),
                    const SizedBox(width: 10),
                    UnconstrainedBox(
                      child: ElevatedButton(
                        child: const Text("تصدير الى اكسل"),
                        onPressed: () => CRMExcelHelper.eventsExcel(controller.eventList, context),
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

              ],
            ),
          ),
          body: TableWidget(
            header: [
              "رقم الشكوي",
              "التاريخ",
              "اسم العميل",
              "رقم الفاتورة",
              "اسم المتابع",
              "حالة الشكوي",
              "اولوية الشكوي",
              "نوع الشكوي",
            ].map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Text(e, textAlign: TextAlign.center,),
            )
            ).toList(),
            headerHeight: 40,
            rows: [
              ...controller.eventList
                  .map((e) => [
                "${e.serial}",
                (e.date == null ? "" : int.DateFormat("yyy-MM-dd").format(e.date!)),
                // "${e.organizationName}",
                (e.customerId ?? ''),
                "${e.invoiceId ?? ''}",
                (e.assignedTo ?? ''),
                "${e.status}",
                "${e.periority}",
                "${e.crmType}",
              ].map((d) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                    d,
                    maxLines: 2, textAlign: TextAlign.center, textDirection: TextDirection.ltr,
                  ),
                );
              }).toList())
                  .toList(),
            ],
            minimumCellWidth: size.width * 0.1,
            rowHeight: 50,
          ),
        ),
      );
    });
  }
}
