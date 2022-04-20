import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoibGVlMDAxIiwiYSI6ImNsMjZjY3Z2ejA5NzQzcG42aHUyYzl0NmQifQ.NncOEf_6-aeBIiCUnTcdYQ';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });
    super.onRequest(options, handler);
  }
}
