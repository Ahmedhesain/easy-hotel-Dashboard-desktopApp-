

class GallaryDeliveryShowRequest {
  final int invId ;
  GallaryDeliveryShowRequest(this.invId);



  Map<String , dynamic> toJson() => {
    'invId' : invId
  };
}