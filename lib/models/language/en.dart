import '../index.dart';

class English implements Language {
  @override
  Locale locale = Locale.vi;

  // Onboard
  @override
  get intro => 'Tìm kiếm\nGia sư Online Tốt nhất';

  @override
  get nextButton => '!Bắt đầu';

  // Login
  @override
  get loginScreenTitle => 'Đăng nhập';

  @override
  get email => 'Địa chỉ E-mail *';

  @override
  get password => 'Mật khẩu *';

  @override
  get forgotPassword => 'Quên mật khẩu?';

  @override
  get login => 'Đăng nhập';

  @override
  get continueWith => 'Hoặc đăng nhập với';

  @override
  get doNotHaveAccount => 'Chưa có tài khoản? ';

  @override
  get signUp => 'Đăng ký';

  @override
  get forgotPasswordTitle => 'Quên mật khẩu';

  // Forgot password
  @override
  get instruction =>
      'Nhập địa chỉ email của bạn. Chúng tôi sẽ gửi cho bạn một đường link để đặt lại mật khẩu.';

  @override
  get emailHint => 'Nhập địa chỉ email';

  @override
  get send => 'Gửi';

  // Sign up
  @override
  get confirmPassword => 'Xác nhận mật khẩu *';

  @override
  get registerWith => 'Hoặc đăng ký vói';

  @override
  get alreadyHaveAccount => 'Đã có tài khoản? ';

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

  // Session card
  @override
  get mark => 'Mark';

  @override
  get noMarking => 'Tutor hasn\'t marked yet';

  @override
  get feedback => 'Give Feedback';

  @override
  get sessionRecord => 'Watch Record';
}
