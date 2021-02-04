import 'package:campus_mobile_experimental/app_networking.dart';
import 'package:campus_mobile_experimental/core/models/public_data.dart';

class PublicDataService {
  PublicDataService();
  String _error;
  PublicDataModel _data;
  bool _isLoading = false;
  DateTime _lastUpdated;

  final NetworkHelper _networkHelper = NetworkHelper();

  final String tokenEndpoint = "https://api-qa.ucsd.edu:8243/token";

  Future<bool> getNewToken() async {
    print('PublicDataService:getNewToken--------------------------------');
    _error = null;

    try {
      /// request headers
      final Map<String, String> tokenHeaders = {
        "content-type": 'application/x-www-form-urlencoded',
        "Authorization":
            "Basic djJlNEpYa0NJUHZ5akFWT0VRXzRqZmZUdDkwYTp2emNBZGFzZWpmaWZiUDc2VUJjNDNNVDExclVh"
      };

      /// fetch data
      var response = await _networkHelper.authorizedPost(
          tokenEndpoint, tokenHeaders, "grant_type=client_credentials");

      /// parse data
      final publicDataModel = PublicDataModel.fromJson(response);
      _data = publicDataModel;
      _lastUpdated = DateTime.now();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // getters
  String get error => _error;
  PublicDataModel get data => _data;
  bool get isLoading => _isLoading;
  DateTime get lastUpdated => _lastUpdated;
}
