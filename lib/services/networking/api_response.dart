import 'package:vf_user_flutter_new/constants/enum/api_status.dart';

class ApiResponse<T> {
  ApiStatus status;

  T data;

  String message;

  ApiResponse.loading(this.message) : status = ApiStatus.LOADING;

  ApiResponse.completed(this.data) : status = ApiStatus.COMPLETED;

  ApiResponse.error(this.message) : status = ApiStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
