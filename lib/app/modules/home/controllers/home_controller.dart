import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_manger/app/core/utils/show_popup_text.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/data/model/cars/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/order_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/review_response.dart';
import 'package:hotel_manger/app/data/repository/application/cars_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


// import 'package:window_manager/window_manager.dart';
import '../../../core/enums/toast_msg_type.dart';
import '../../../core/values/app_constants.dart';

class HomeController extends GetxController {


}
