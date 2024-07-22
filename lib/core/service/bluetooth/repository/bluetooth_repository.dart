import 'package:dartz/dartz.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/datasourse/bluetooth_datasource.dart';

abstract class BluetoothRepository {
  Future<Either<Failure, List<BluetoothDevice>>> getConnectedDevice();
}

class BluetoothRepositoryImpl extends BluetoothRepository {
  final BluetoothDataSource bluetoothDataSource;

  BluetoothRepositoryImpl({
    required this.bluetoothDataSource,
  });

  @override
  Future<Either<CacheFailure, List<BluetoothDevice>>> getConnectedDevice() async {
    try {
      final model = await bluetoothDataSource.getConnectedDevice();

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }
}
