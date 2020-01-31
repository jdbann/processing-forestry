class EventStream {
  Challenge challenge;

  EventStream(Challenge challenge_) {
    challenge = challenge_;
  }

  void emit(Event event) {
    challenge.listen(event);
  }
}
