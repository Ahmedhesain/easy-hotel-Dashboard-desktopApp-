import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/modules/crm/controller/crm_event_controller.dart';
import '../../../components/flutter_typeahead.dart';
import '../../../components/icon_button_widget.dart';
import '../../../core/values/app_colors.dart';
import '../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../../data/model/invoice/dto/response/gallery_response.dart';

class CrmEventView extends GetView<CrmEventController> {
  const CrmEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Obx(() {
        return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      SizedBox(
                          width: size.width * 0.07,
                          child: const Text('اختيار المعرض:')),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: size.width * 0.2,
                        child: DropdownSearch<GalleryResponse>(
                          items: controller.galleries,
                          selectedItem: controller.selectedCrmEventGallery.value,
                          onChanged: (g) {
                            controller.selectedCrmEventGallery(g);
                          },
                          itemAsString: (gallery) => gallery.name ?? "",
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      SizedBox(
                          width: size.width * 0.07,
                          child: const Text('العميل:')),
                      const SizedBox(width: 5),
                      Container(
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          color: AppColors.appGreyLight,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TypeAheadFormField<FindCustomerResponse>(
                            itemBuilder: (context, client) {
                              return SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text("${client.name} ${client.code}"),
                                ),
                              );
                            },
                            suggestionsCallback: (filter) => controller.customers,
                            onSuggestionSelected: (value) async {
                              controller.crmCustomerController.text = "${value.name} ${value.code}";
                              controller.selectedCrmCustomer(value);
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              textInputAction: TextInputAction.next,
                              focusNode: controller.crmCustomerFieldFocusNode,
                              onSubmitted: (_) => controller.getCustomersByCodeForInvoice(),
                              controller: controller.crmCustomerController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  // disabledBorder: InputBorder.none,
                                  // enabledBorder: InputBorder.none,
                                  // focusedBorder: InputBorder.none,
                                  hintText: "ابحث عن عميل معين",
                                  isDense: true,
                                  hintMaxLines: 2,
                                  contentPadding: const EdgeInsets.all(5),
                                  suffixIconConstraints: const BoxConstraints(maxWidth: 50),
                                  suffixIcon: IconButtonWidget(
                                    icon: Icons.search,
                                    onPressed: () {
                                      controller.getCustomersByCodeForInvoice();
                                    },
                                  )),
                            )),
                      )

                    ],
                  ),
                )

              ],
            ),
          ),
        );
      }),
    );
  }
}
