import 'package:dartz/dartz.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/bluetooth_repository.dart';

class GetConnectedDeviceUseCase extends UseCase<List<BluetoothDevice>?, NoParams> {
  final BluetoothRepository bluetoothRepository;

  GetConnectedDeviceUseCase(this.bluetoothRepository);

  @override
  Future<Either<Failure, List<BluetoothDevice>>> call(NoParams params) async {
    final response = await bluetoothRepository.getConnectedDevice();
    return response;
  }
}
