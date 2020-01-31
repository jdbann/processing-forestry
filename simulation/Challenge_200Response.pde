class Challenge_200Response extends Challenge {
  Challenge_200Response() {
  }

  void listen(Event event) {
    if (event instanceof ClientSuccessEvent) {
      complete = true;
    }
  }
}
