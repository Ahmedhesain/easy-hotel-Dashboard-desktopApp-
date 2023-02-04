class LoginResponse{
LoginResponse({
    required this.accountIdApi,
    required this.branchSelected,
    required this.companySelected,
    required this.galleryId,
    required this.galleryName,
    required this.galleryType,
    required this.id,
    required this.name,
    required this.userScreens,
  });

  int accountIdApi;
  int branchSelected;
  int companySelected;
  int galleryId;
  String galleryName;
  int galleryType;
  int id;
  String name;
  Map<String, ScreenPermission> userScreens;

  factory LoginResponse.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> json = data.containsKey("data")?data["data"]:data;
    json["userScreens"] = data["userScreens"];
    final screenPermission = <String, ScreenPermission>{};
    final screens = json["userScreens"];
    if(screens != null){
      final entry = screens["entry"];
      for (Map<String,dynamic> element in entry??[]) {
        screenPermission[element["key"]] = ScreenPermission.fromJson(element["value"]!);
      }
    }
    return LoginResponse(
    accountIdApi: json["accountIdAPI"],
    branchSelected: json["branchSelected"],
    companySelected: json["companySelected"],
    galleryId: json["galleryId"],
    galleryName: json["galleryName"],
    galleryType: json["galleryType"],
    id: json["id"],
    name: json["name"],
    userScreens: screenPermission,
  );
  }

  Map<String, dynamic> toJson() => {
    "accountIdAPI": accountIdApi,
    "branchSelected": branchSelected,
    "companySelected": companySelected,
    "galleryId": galleryId,
    "galleryName": galleryName,
    "galleryType": galleryType,
    "id": id,
    "name": name,
    "userScreens": {
      "entry": [
        for(final entry in userScreens.entries)
          {"key":entry.key, "value": entry.value.toJson()}
      ]
    }
  };
}

class ScreenPermission{

  ScreenPermission({required this.add,required this.delete,required this.edit,required this.view,required this.screenId});

  final bool? add;
  final bool? delete;
  final bool? edit;
  final bool? view;
  final int? screenId;


  factory ScreenPermission.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> json = data.containsKey("data")?data["data"]:data;
    return ScreenPermission(
      add: json["add"],
      delete: json["delete"],
      edit: json["edit"],
      view: json["view"],
      screenId: json["screenId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "add": add,
    "delete": delete,
    "edit": edit,
    "view": view,
    "screenId": screenId,
  };

}