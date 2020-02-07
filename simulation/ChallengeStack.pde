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
    if (readyForNextChallenge()) {
      currentChallengeIndex ++;
      currentChallengeIndex = min(currentChallengeIndex, challengeStack.size() - 1);
    }

    currentChallenge().tick();
  }

  boolean readyForNextChallenge() {
    float challengeTransitionDuration = frameRate * 5;
    return currentChallenge().complete && frameCount - currentChallenge().completedAt >= challengeTransitionDuration;
  }

  Challenge currentChallenge() {
    return challengeStack.get(currentChallengeIndex);
  }
}
