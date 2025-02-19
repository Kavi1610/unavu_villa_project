import 'package:unavu_villa_project/models/order_list_response_model.dart';
import 'package:unavu_villa_project/models/report_response_model.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';

class DashboardProvider extends BaseProvider {
  Future<OrderListResponse> fetchOrderList(String id) async {
    try {
      String token = "";
      await fetchToken().then((val) {
        token = val!;
      });
      final response = await get(
          "${ApiEndpoints.allOrders}?branchid=$id&page=1&size=50",
          headers: {"Authorization": "Bearer $token"});
      if (response.hasError) {
        return Future.error("Something Went Wrong");
      } else {
        return OrderListResponse.fromJson(response.body);
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future<ReportResponseModel> fetchReport() async {
    try {
      String token = "";
      await fetchToken().then((val) {
        token = val!;
      });
      final response = await get(ApiEndpoints.getReport,
          headers: {"Authorization": "Bearer $token"});
      if (response.hasError) {
        return Future.error("Something Went Wrong");
      } else {
        return ReportResponseModel.fromJson(response.body);
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
