class Sensor {
  double accX, accY, accZ, accT, gyrX, gyrY, gyrZ, gyrT;

  Sensor({
    this.accX = 0,
    this.accY = 0,
    this.accZ = 0,
    this.accT = 0,
    this.gyrX = 0,
    this.gyrY = 0,
    this.gyrZ = 0,
    this.gyrT = 0,
  });

  Map<String, String> toJson() {
    return {
      'accX': accX.toString(),
      'accY': accY.toString(),
      'accZ': accZ.toString(),
      'accT': accT.toString(),
      'gyrX': gyrX.toString(),
      'gyrY': gyrY.toString(),
      'gyrZ': gyrZ.toString(),
      'gyrT': gyrT.toString(),
    };
  }
}
