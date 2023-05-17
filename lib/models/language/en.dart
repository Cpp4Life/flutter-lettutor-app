import '../index.dart';

class English implements Language {
  @override
  Locale locale = Locale.en;

  // Onboard
  @override
  get intro => 'English\nLanguage Teaching';

  @override
  get nextButton => 'Get Started';

  // Login
  @override
  get loginScreenTitle => 'Sign in';

  @override
  get email => 'Email *';

  @override
  get password => 'Password *';

  @override
  get forgotPassword => 'Forgot Password?';

  @override
  get login => 'Log In';

  @override
  get continueWith => 'Or continue with';

  @override
  get doNotHaveAccount => 'Don\'t have account? ';

  @override
  get signUp => 'Sign up';

  // Forgot password
  @override
  get forgotPasswordTitle => 'Forgot password';

  @override
  get instruction =>
      'Enter your email address and we\'ll send you a link to reset your password';

  @override
  get emailHint => 'Enter your email';

  @override
  get send => 'Send';

  // Sign up
  @override
  get confirmPassword => 'Confirm password *';

  @override
  get registerWith => 'Or continue with';

  @override
  get alreadyHaveAccount => 'Already have an account? ';

  // Home
  @override
  get homeTitle => 'Home';

  @override
  get welcomeMessage => 'Welcome to LetTutor!';

  @override
  get bookButtonTitle => 'Book a lesson';

  @override
  get totalLessonTime => 'Total lesson time is';

  @override
  get upcomingLesson => 'Upcoming lesson';

  @override
  get recommendedTutor => 'Recommended Tutors';

  @override
  get seeAll => 'See all';

  @override
  get enterLessonRoom => 'Enter lesson room';

  // Course
  @override
  get courseSearchHint => 'Search course';

  @override
  get courseTitle => 'Course';

  @override
  get ebook => 'Ebook';

  @override
  get ebookSearchHint => 'Search ebook';

  // Course detail
  @override
  get aboutCourse => 'About Course';

  @override
  get courseTopics => 'Topics';

  @override
  get courseTutor => 'Tutor';

  @override
  get level => 'Level';

  @override
  get overview => 'Overview';

  @override
  get whatYouGet => 'What will you be able to do?';

  @override
  get whyThisCourse => 'Why take this course?';

  // Upcoming
  @override
  get cancel => 'Cancel';

  @override
  get goToMeeting => 'Go to meeting';

  @override
  get upcomingTitle => 'Upcoming';

  @override
  get cancelConfirmMessage => 'Are you sure to cancel meeting?';

  @override
  get cancelFailed => 'Cannot cancel meeting less than 2 hours to the starting point!';

  @override
  get cancelSuccessfully => 'Cancel meeting successfully';

  // Tutor
  @override
  get tutorList => 'Tutors';

  @override
  get tutorSearchHint => 'Search Tutors';

  @override
  get tutorTitle => 'Tutors';

  // Tutor detail
  @override
  get bookingTutorButton => 'Booking';

  @override
  get course => 'Course';

  @override
  get education => 'Education';

  @override
  get experience => 'Experience';

  @override
  get interests => 'Interests';

  @override
  get languages => 'Languages';

  @override
  get message => 'Message';

  @override
  get profession => 'Profession';

  @override
  get ratingAndComments => 'Rating and Comment';

  @override
  get report => 'Report';

  @override
  get specialties => 'Specialties';

  // ChatGPT
  @override
  get chatGPTTitle => 'ChatGPT';

  @override
  get typeMessageHint => 'Type a message...';

  // Settings
  @override
  get advancedSettings => 'Advanced Settings';

  @override
  get facebook => 'Facebook';

  @override
  get logout => 'Log out';

  @override
  get ourWebsite => 'Our Website';

  @override
  get sessionHistory => 'Session History';

  @override
  get settingsTitle => 'Settings';

  @override
  get version => 'Version';

  @override
  get sessionSearchHint => 'Search session history';

  @override
  get changePassword => 'Change Password';

  @override
  get newPassword => 'New password *';

  // Session card
  @override
  get mark => 'Mark';

  @override
  get noMarking => 'Tutor hasn\'t marked yet';

  @override
  get feedback => 'Give Feedback';

  @override
  get sessionRecord => 'Watch Record';

  // Profile
  @override
  get birthday => 'Birthday';

  @override
  get country => 'Country';

  @override
  get countryHint => 'Please select your country';

  @override
  get levelHint => 'Please select your level';

  @override
  get phone => 'Phone number';

  @override
  get profileTitle => 'Profile';

  @override
  get wantToLearn => 'Want to Learn';

  @override
  get phoneHint => 'Phone Number';
}
