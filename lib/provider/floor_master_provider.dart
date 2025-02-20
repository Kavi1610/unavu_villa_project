import 'package:get/get.dart';
import 'package:unavu_villa_project/models/floor_master_model.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';

class FloorMasterProvider extends BaseProvider {
  Future<FloorMasterResponse> fetchFloorMasterList() async {
    try {
      // Make the API call
      final response = await get(
        ApiEndpoints.floorMaster,
      );

      // Check for a successful response
      if (response.hasError) {
        return Future.error("Something Went Wrong");
      } else {
        return FloorMasterResponse.fromJson(
            response.body); // Parse the response
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
