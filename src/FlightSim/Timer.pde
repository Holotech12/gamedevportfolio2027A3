class Timer {
  int savedTime;
  int totalTime;
  int passedTime;
  Timer(int totalTime) {
    this.totalTime = totalTime;
  }
  void start() {
    savedTime = millis();
  }
  boolean isFinished() {
    float passedTime = (millis() - savedTime) / 1000;
    return passedTime>(totalTime/1000);
  }
}
