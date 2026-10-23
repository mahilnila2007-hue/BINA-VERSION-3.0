/// Accessible English Strings for ReHabRep.
/// - Simple, plain language
/// - Short corrective cues (max 4 words)
/// - Friendly 1-sentence explanations for permissions
/// - TalkBack semantic labels
class AppStrings {
  AppStrings._();

  // App Identity
  static const appName = 'ReHabRep';
  static const appSubtitle = 'Post-Surgery Rehabilitation Assistant';
  static const safetyNotice = 'Supports rehab monitoring. Does not diagnose.';

  // Short Corrective Cues (Max 4 words, spoken slowly & clearly)
  static const cueGoodRep = 'Good repetition';
  static const cueBendMore = 'Bend a little more';
  static const cueSlowDown = 'Slow down';
  static const cueRestNow = 'Rest now';
  static const cueStepBack = 'Step back slightly';
  static const cueHoldPosition = 'Hold right there';
  static const cueKeepGoing = 'Keep going';

  // Camera & Wearable Friendly 1-Sentence Explanations
  static const cameraPermissionExplanation =
      'ReHabRep needs camera access to observe your movement and guide your exercise.';
  static const wearablePairingExplanation =
      'Connect an optional wrist sensor to record heart rate and muscle signals.';

  // Patient Home Screen
  static const greetingMorning = 'Good morning';
  static const greetingAfternoon = 'Good afternoon';
  static const greetingEvening = 'Good evening';
  static const todayExerciseTitle = "Today's Exercise";
  static const buttonStartExercise = 'START EXERCISE';
  static const todayProgress = "Today's Progress";
  static const lastSessionSummary = 'Last session: 24 of 30 good repetitions completed.';

  // Patient Done Screen
  static const doneTitle = 'Well Done!';
  static const doneSubheading = 'Session completed successfully.';
  static const buttonFinish = 'FINISH';
  static const encouragementGood = 'Great effort! Your joints are getting stronger every day.';

  // Destructive Actions
  static const confirmStopTitle = 'Stop session?';
  static const confirmStopMessage = 'Your progress so far will be saved.';
  static const confirmYesStop = 'Yes, stop';
  static const confirmNoContinue = 'No, continue';

  // Fallbacks & Low-confidence
  static const cueAdjustCameraVisibility = 'Move so I can see your whole leg/arm';
}
