


class EventDTO {
  EventDTO(
      {this.assignedTo,
        this.customerId,
        this.gallarySelected,
        this.id,
        this.invoiceId,
        this.periority,
        this.serial,
        this.status,
        this.subject,
        this.discription,
        this.seeMore = false,
        this.crmType,
        this.customerPhone,
        this.gallaryId,
        this.date
      });

  String? assignedTo;
  String? customerId;
  String? customerPhone;
  String? gallarySelected;
  int? id;
  int? gallaryId;
  int? invoiceId;
  String? periority;
  int? serial;
  String? status;
  String? subject;
  String? discription;
  String? crmType;
  bool? seeMore = false;
  DateTime? date ;
  static List<EventDTO> fromList(dynamic json) => List.from(json.map((e) => EventDTO.fromJson(e)));

  factory EventDTO.fromJson(Map<String, dynamic> json) => EventDTO(
      assignedTo: json["assignedTo"] == null ? null : json["assignedTo"],
      customerId: json["customerId"] == null ? null : json["customerId"],
      gallarySelected: json["gallarySelected"] == null ? null : json["gallarySelected"],
      gallaryId: json["gallaryId"] == null ? null : json["gallaryId"],
      id: json["id"] == null ? null : json["id"],
      invoiceId: json["invoiceId"] == null ? null : json["invoiceId"],
      periority: json["periority"] == null ? null : json["periority"],
      serial: json["serial"] == null ? null : json["serial"],
      status: json["status"] == null ? null : json["status"],
      subject: json["subject"] == null ? null : json["subject"],
      discription: json["discription"] == null ? null : json["discription"],
      crmType: json["crmType"] == null ? null : json["crmType"],
      date: json["date"] == null ? null : DateTime.tryParse(json["date"]),
      customerPhone: json["customerPhone"] == null ? null : json["customerPhone"],
      seeMore: false);
}
