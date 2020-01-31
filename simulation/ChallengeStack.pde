class ChallengeStack {
  ArrayList<Challenge> challengeStack;
  int currentChallengeIndex;

  ChallengeStack() {
    challengeStack = new ArrayList<Challenge>();
    challengeStack.add(new Challenge1());
    challengeStack.add(new Challenge2());
    currentChallengeIndex = 0;
  }

  void tick() {
    if (currentChallenge().isComplete()) {
      currentChallengeIndex ++;
      currentChallengeIndex = min(currentChallengeIndex, challengeStack.size() - 1);
    }

    currentChallenge().tick();
  }

  Challenge currentChallenge() {
    return challengeStack.get(currentChallengeIndex);
  }
}
