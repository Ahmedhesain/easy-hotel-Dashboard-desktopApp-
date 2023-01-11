import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/text_field_widget.dart';
import 'package:toby_bills/app/data/model/common/symbol_model_dto.dart';
import 'package:toby_bills/app/modules/crm/controller/crm_event_controller.dart';
import '../../../components/dropdown_widget.dart';
import '../../../components/flutter_typeahead.dart';
import '../../../components/icon_button_widget.dart';
import '../../../data/model/crm/response/follower_response.dart';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.5 ,
                  child: Card(
                    elevation: 2,
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: size.width * 0.07,
                                child: const Text('اضافة شكوي', style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: size.width * 0.07,
                                    child: const Text('اختيار المعرض')),
                                const SizedBox(width: 5),
                                Container(
                                  width: size.width * 0.2,
                                  color: Colors.white,
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
                                    child: const Text('العميل')),
                                const SizedBox(width: 5),
                                Container(
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: size.width * 0.07,
                                    child: const Text('نوع الشكوي')),
                                const SizedBox(width: 5),
                                Container(
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropDownWidget<SymbolDTO>(
                                    items: controller.eventTypes.
                                    map((element) =>
                                        DropdownMenuItem<SymbolDTO>(
                                            child: Text(element.name ?? '')
                                        )).toList(),
                                    onChanged: (val) => controller.selectedEventType.value = val,

                                  )
                                )

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: size.width * 0.07,
                                    child: const Text('الاولوية')),
                                const SizedBox(width: 5),
                                Container(
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropDownWidget<SymbolDTO>(
                                    items: controller.eventPriorityList.
                                    map((element) =>
                                        DropdownMenuItem<SymbolDTO>(
                                            child: Text(element.name ?? '')
                                        )).toList(),
                                    onChanged: (val) => controller.selectedEventPriority.value = val,

                                  )
                                )

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: size.width * 0.07,
                                    child: const Text('المتابع')),
                                const SizedBox(width: 5),
                                Container(
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropDownWidget<FollowerResponse>(
                                    items: controller.followersList.
                                    map((element) =>
                                        DropdownMenuItem<FollowerResponse>(
                                            child: Text(element.name ?? '')
                                        )).toList(),
                                    onChanged: (val) => controller.selectedFollower.value = val,

                                  )
                                )

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: size.width * 0.07,
                                    child: const Text('عنوان الشكوي')),
                                const SizedBox(width: 5),
                                Container(
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextFieldWidget(
                                    controller: controller.crmEventAddressController,

                                  )
                                )

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: size.width * 0.07,
                                    child: const Text('نص الشكوي')),
                                const SizedBox(width: 5),
                                Container(
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)
                                  ),
                                  child: TextFieldWidget(
                                    controller: controller.crmEventTextController,
                                    maxLines: 8,

                                  )
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonWidget(text: "رجوع", onPressed: () => Get.back(),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonWidget(text: "حفظ", onPressed: (){}),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonWidget(text: "جديد", onPressed: (){},),
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
