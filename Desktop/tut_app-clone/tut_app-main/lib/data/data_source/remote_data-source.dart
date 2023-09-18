// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';

import '../responses/responses.dart';
// remote data source to get data from network
abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LogInRequest logInRequest);
}

// remote data source implementation to get data from network
class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient appServiceClient;
  RemoteDataSourceImpl(
    this.appServiceClient,
  );
  // login method to get data from network
  // this class send data to repo impl class then repo class 
  //use mapper to map it into object
  @override
  Future<AuthenticationResponse> login(LogInRequest logInRequest) async {
    return await appServiceClient.login(
        logInRequest.email, logInRequest.password);
  }
}
