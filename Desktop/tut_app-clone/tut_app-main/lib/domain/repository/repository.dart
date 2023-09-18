import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../model/models.dart';
  // repository to get data from network
abstract class Repository{
  // login method to get data from network
  // with Either to handle success and failure
  Future<Either<Failure,Authentication>> login(LogInRequest logInRequest);
}