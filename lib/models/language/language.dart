enum Locale {
  vi,
  en,
}

abstract class Language {
  late final Locale locale;

  // Onboard
  get intro;
  get nextButton;

  // Login
  get loginScreenTitle;
  get email;
  get password;
  get forgotPassword;
  get login;
  get continueWith;
  get doNotHaveAccount;
  get signUp;

  // Forgot password
  get forgotPasswordTitle;
  get instruction;
  get emailHint;
  get send;

  // Sign up
  get confirmPassword;
  get registerWith;
  get alreadyHaveAccount;

  // Home
  get homeTitle;
  get welcomeMessage;
  get bookButtonTitle;
  get totalLessonTime;
  get upcomingLesson;
  get recommendedTutor;
  get seeAll;

  // Course
  get courseTitle;
  get ebook;
  get courseSearchHint;
  get ebookSearchHint;

  // Course detail
  get courseTopics;
  get courseTutor;
  get aboutCourse;
  get overview;
  get whyThisCourse;
  get whatYouGet;
  get level;

  // Upcoming
  get upcomingTitle;
  get cancel;
  get goToMeeting;
  get cancelConfirmMessage;
  get cancelSuccessfully;
  get cancelFailed;

  // Tutor
  get tutorTitle;
  get tutorList;
  get tutorSearchHint;

  // Tutor detail
  get bookingTutorButton;
  get message;
  get report;
  get languages;
  get education;
  get experience;
  get interests;
  get profession;
  get specialties;
  get course;
  get ratingAndComments;

  // ChatGPT
  get chatGPTTitle;
  get typeMessageHint;

  // Settings
  get settingsTitle;
  get sessionHistory;
  get sessionSearchHint;
  get advancedSettings;
  get ourWebsite;
  get facebook;
  get version;
  get logout;

  // Session card
  get mark;
  get noMarking;
  get feedback;
  get sessionRecord;
}
