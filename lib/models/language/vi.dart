import '../index.dart';

class Vietnamese implements Language {
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
  get homeTitle => 'Trang chủ';

  @override
  get welcomeMessage => 'Chào mừng bạn đến với LetTutor!';

  @override
  get bookButtonTitle => 'Đặt lịch';

  @override
  get totalLessonTime => 'Tổng thời gian học là';

  @override
  get upcomingLesson => 'Buổi học tiếp theo';

  @override
  get recommendedTutor => 'Gia sư được đề xuất';

  @override
  get seeAll => 'Tất cả';

  // Course
  @override
  get courseSearchHint => 'Tìm kiếm khoá học';

  @override
  get courseTitle => 'Khoá học';

  @override
  get ebook => 'Giáo trình';

  @override
  get ebookSearchHint => 'Tìm kiếm giáo trình';

  // Course detail
  @override
  get aboutCourse => 'Về khoá học';

  @override
  get courseTopics => 'Chủ đề';

  @override
  get courseTutor => 'Gia sư';

  @override
  get level => 'Đối tượng';

  @override
  get overview => 'Tổng quan';

  @override
  get whatYouGet => 'Bạn có thể làm gì?';

  @override
  get whyThisCourse => 'Tại sao bạn nên học khoá học này?';

  // Upcoming
  @override
  get cancel => 'Huỷ bỏ';

  @override
  get goToMeeting => 'Vào phòng học';

  @override
  get upcomingTitle => 'Sắp diễn ra';

  @override
  get cancelConfirmMessage => 'Bạn chắc chắn muốn huỷ buổi học?';

  @override
  get cancelFailed => 'Bạn chỉ có thể huỷ buổi học trước giờ học 2 tiếng!';

  @override
  get cancelSuccessfully => 'Huỷ buổi học thành công';

  // Tutor
  @override
  get tutorList => 'Danh sách Tutor';

  @override
  get tutorSearchHint => 'Tìm kiếm gia sư';

  @override
  get tutorTitle => 'Gia sư';

  // Tutor detail
  @override
  get bookingTutorButton => 'Đặt lịch ngay';

  @override
  get course => 'Khoá học';

  @override
  get education => 'Học vấn';

  @override
  get experience => 'Kinh nghiệm';

  @override
  get interests => 'Sở thích';

  @override
  get languages => 'Ngôn ngữ';

  @override
  get message => 'Nhắn tin';

  @override
  get profession => 'Nghề nghiệp';

  @override
  get ratingAndComments => 'Đánh giá và bình luận';

  @override
  get report => 'Báo cáo';

  @override
  get specialties => 'Chuyên môn';

  // ChatGPT
  @override
  get chatGPTTitle => 'ChatGPT';

  @override
  get typeMessageHint => 'Soạn tin nhắn tại đây...';

  // Settings
  @override
  get advancedSettings => 'Cài đặt nâng cao';

  @override
  get facebook => 'Facebook';

  @override
  get logout => 'Đăng xuất';

  @override
  get ourWebsite => 'Đi đến Website';

  @override
  get sessionHistory => 'Lịch sử học';

  @override
  get settingsTitle => 'Cài đặt';

  @override
  get version => 'Phiên bản App';

  @override
  get sessionSearchHint => 'Tìm kiếm lịch sử buổi học';

  // Session card
  @override
  get mark => 'Điểm số:';

  @override
  get noMarking => 'Gia sư chưa chấm điểm';

  @override
  get feedback => 'Đánh giá';

  @override
  get sessionRecord => 'Xem lại buổi học';
}
