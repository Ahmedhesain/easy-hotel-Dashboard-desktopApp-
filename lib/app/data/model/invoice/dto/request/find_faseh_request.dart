class FindFasehRequest{

  FindFasehRequest({required this.serial});

  final String serial;

  Map<String, dynamic> toJson(){
    return {
      "serial": serial
    };
  }
}
