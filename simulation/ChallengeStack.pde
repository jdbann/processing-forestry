class ChallengeStack {
  ArrayList<Challenge> challengeStack;
  int currentChallengeIndex;

  ChallengeStack() {
    challengeStack = new ArrayList<Challenge>();
    challengeStack.add(new Challenge1());
    challengeStack.add(new Challenge());
    currentChallengeIndex = 0;
  }

  void tick() {
    if (currentChallenge().isComplete()) {
      currentChallengeIndex ++;
      currentChallengeIndex = min(currentChallengeIndex, challengeStack.size());
    }

    currentChallenge().tick();
  }

  Challenge currentChallenge() {
    return challengeStack.get(currentChallengeIndex);
  }
}
