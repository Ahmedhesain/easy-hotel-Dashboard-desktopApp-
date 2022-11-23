import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';

class OfferOneRequest{

  final List<InvoiceDetailsModel> invoiceDetailApiList;
  final int galleryType;

  OfferOneRequest({required this.invoiceDetailApiList, required this.galleryType});


  Map<String, dynamic> toJson(){
    return {
      "invoiceDetailApiList" : invoiceDetailApiList.map((e) => e.toJson()).toList(),
      "galleryType": galleryType
    };
  }

}