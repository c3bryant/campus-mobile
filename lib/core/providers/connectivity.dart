import 'package:campus_mobile_experimental/app_constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetConnectivityProvider extends ChangeNotifier {
  bool _noInternet = false;
  bool get noInternet => _noInternet;

  Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        _noInternet = true;
        notifyListeners();
        _showOfflineAlert(Get.context!);
      } else {
        _noInternet = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void monitorInternet() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        _noInternet = true;
        notifyListeners();
        _showOfflineAlert(Get.context!);
      } else {
        _noInternet = false;
        notifyListeners();
      }
    });
  }

  void _showOfflineAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(ConnectivityConstants.offlineTitle),
      content: Text(ConnectivityConstants.offlineAlert),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Ok'),
          child: Text('Ok'),
          style: TextButton.styleFrom(
            primary: Theme.of(context).buttonColor,
          ),
        ),
      ],
    );

    Future.delayed(
        Duration.zero,
        () => {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return alert;
                },
              )
            });
  }
}
