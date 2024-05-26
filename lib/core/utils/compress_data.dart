import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/locator.dart';

List<int> compressArray(List<int> inputArray) {
  final targetSize = sl<GlobalSettingsService>().appSettings.copressSized;
  if (inputArray.length <= targetSize) {
    return inputArray;
  }

  int inputSize = inputArray.length;
  List<int> compressedArray = List.filled(targetSize, 0);

  for (int i = 0; i < targetSize; i++) {
    int startIndex = (i * inputSize / targetSize).floor();
    int endIndex = ((i + 1) * inputSize / targetSize).floor();

    double sum = 0.0;
    int count = 0;

    for (int j = startIndex; j < endIndex; j++) {
      sum += inputArray[j];
      count++;
    }

    compressedArray[i] = (sum / count).round();
  }

  return compressedArray;
}
