class GalleryRequest {

  GalleryRequest({
    this.branchId,
    this.id,
  });

  int? branchId;
  int? id;

  Map<String, dynamic> toJson() => {
    "branchId" : branchId,
    "id": id
  };

}
