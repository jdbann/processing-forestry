class ChallengeStack {
  ArrayList<Challenge> challengeStack;
  int currentChallengeIndex;

  ChallengeStack() {
    challengeStack = new ArrayList<Challenge>();
    challengeStack.add(new Challenge_200Response());
    challengeStack.add(new Challenge_Sandbox());
    currentChallengeIndex = 0;
  }

  void tick() {
    if (currentChallenge().complete) {
      currentChallengeIndex ++;
      currentChallengeIndex = min(currentChallengeIndex, challengeStack.size() - 1);
    }

    currentChallenge().tick();
  }

  Challenge currentChallenge() {
    return challengeStack.get(currentChallengeIndex);
  }
}
