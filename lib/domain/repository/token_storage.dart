import 'package:cinema_booking/data/datasource/app_datasource.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class TokenStorage {
  String? accessToken;
  DataSource? source;


  authorize() async {
    var instance = await SharedPreferences.getInstance();
    accessToken = instance.getString('token');
    if (source == null) {
      _getSource();
    }
    if (accessToken == null) {
      accessToken = await _serverAuthorise();
      instance.setString('token', accessToken!);
      source!.authToken = accessToken;
    }
    else{
      await _checkToken(instance);
    }
  }

  _getSource() {
    source = GetIt.I<DataSource>();
  }

  Future<String> _serverAuthorise() async{
    var sessionToken = await source!.getSessionToken();
    var deviceId = await PlatformDeviceId.getDeviceId;
    return await source!.getAccessToken(sessionToken, deviceId ?? '');
  }

  _checkToken(SharedPreferences instance) async{
    source!.authToken = accessToken;
    try{
      source!.getUser();
    }catch(e){
      accessToken = await _serverAuthorise();
      instance.setString('token', accessToken!);
      source!.authToken = accessToken;
    }
  }
}
