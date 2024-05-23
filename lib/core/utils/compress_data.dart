List<int> compressArray(List<int> inputArray, {int targetSize = 100}) {
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
