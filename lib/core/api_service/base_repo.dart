import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/core/errors/failures.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/network/check_internet.dart';

class BaseRepo {
  static Future<Either<Failure, dynamic>> repoRequest(
      {required Function request}) async {
    NetworkInfo networkInfo = locator.get<NetworkInfo>();
    if (await networkInfo.isConnected) {
      try {
        final info = await request();
        return Right(info);
      } on Failure catch (f) {
        return Left(f);
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
