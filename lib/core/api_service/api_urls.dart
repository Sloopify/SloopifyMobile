class ApiUrls{
  static const String baseUrl ="https://dev.sloopify.com/public/api/v1/";


  ///***************************auth ***************///////////////
static const String signUp="auth/register/create-account";
static const String sendOtpByRegister="auth/register/send-otp";
static const String verifyOtpByRegister="auth/register/verify-otp";
static const String completeInterests="auth/register/complete-interests";
static const String completeGender="auth/register/complete-gender";
static const String completeBirthDay="auth/register/complete-birthday";
static const String completeRefferDay="auth/register/complete-reffer";
static const String completeImage="auth/register/complete-image";
static const String loginWithEmail="auth/login-email";
static const String loginWithPhone="auth/login-mobile";
static const String loginWithOtp="auth/login-otp";
static const String verifyLoginWithOtp="auth/verify-login-otp";
static const String verifyUserToken="auth/verify-token";
static const String getInterests="auth/register/get-interests-by-category-name";
static const String getAllCategories="auth/register/get-interest-category";
static const String requestCodeForForgetPassword="auth/forgot-password/send-otp";
static const String verifyCodeForForgetPassword="auth/forgot-password/verify-otp";
static const String changePassword="auth/forgot-password/reset-password";


////////////////////***************create post apis***************** ///////////////////////////
  static const String getFriends="post/get-friends";
  static const String searchFriends="post/search-friends";
  static const String searchActivityByName="post/search-activity";
  static const String searchActivityCategoryByName="post/search-activity-by-category";
  static const String searchFeelingName="post/search-feeling";
  static const String getActivityByCategoryName="post/get-activity-by-category-name";
  static const String getCategoriesActivities="post/get-activity-category";
  static const String getFeelings="post/get-feeling";
  static const String getPlaces="post/get-user-places";
  static const String getPlaceById="post/get-user-place-by-id";
  static const String searchPlaces="post/search-user-places";
  static const String createPlace="post/create-user-place";
  static const String updatePlace="post/update-user-place";






}