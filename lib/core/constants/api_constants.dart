class ApiConstants {
  // =========================================================
  // BASE URL (Change with Environment)
  // =========================================================
  static const String baseUrl = "https://api.tryde.com"; // Production

  // If required, you can keep multiple env:
  static const String devBaseUrl = "https://dev.api.tryde.com";
  static const String stagingBaseUrl = "https://staging.api.tryde.com";

  // =========================================================
  // AUTHENTICATION
  // =========================================================
  static const String login = "/auth/login";
  static const String sendOtp = "/auth/send-otp";
  static const String verifyOtp = "/auth/verify-otp";
  static const String refreshToken = "/auth/refresh-token";

  // =========================================================
  // USER MODULE
  // =========================================================
  static const String userProfile = "/user/profile";
  static const String updateProfile = "/user/profile/update";
  static const String deleteUser = "/user/delete";
  static const String updateFcmToken = "/user/update-fcm";

  // =========================================================
  // DRIVER MODULE
  // =========================================================
  static const String driverRegister = "/driver/register";
  static const String driverKyc = "/driver/kyc/upload";
  static const String driverLogin = "/driver/login";
  static const String driverStatus = "/driver/update-status";
  static const String driverLocationUpdate = "/driver/location/update";
  static const String driverSelfieVerify = "/driver/selfie/verify";

  // =========================================================
  // RIDE BOOKING
  // =========================================================
  static const String rideEstimate = "/ride/estimate";
  static const String rideCreate = "/ride/create";
  static const String rideCancel = "/ride/cancel";
  static const String rideStatus = "/ride/status";
  static const String rideLiveTracking = "/ride/track/live";
  static const String rideComplete = "/ride/complete";
  static const String rideHistory = "/ride/history";

  // =========================================================
  // RIDE SHARING SYSTEM
  // =========================================================
  static const String rideShareList = "/ride/share/list";
  static const String rideJoinShare = "/ride/share/join";
  static const String rideShareFareUpdate = "/ride/share/fare/update";

  // =========================================================
  // INCIDENT REPORTING (Driver Way Alerts)
  // =========================================================
  static const String reportIncident = "/driver/incident/report";
  static const String getIncidents = "/driver/incident/list";

  // =========================================================
  // PORTER / LOGISTICS (Consignment)
  // =========================================================
  static const String createConsignment = "/consignment/create";
  static const String consignmentList = "/consignment/list";
  static const String consignmentDetails = "/consignment/details";
  static const String consignmentTrack = "/consignment/track";
  static const String multiDropUpdate = "/consignment/multi-drop/update";

  // =========================================================
  // MULTI-CONSIGNMENT SYSTEM
  // =========================================================
  static const String driverRouteLoads = "/driver/route/loads";
  static const String driverAcceptLoad = "/driver/load/accept";
  static const String updateDropSequence = "/consignment/drop/update";
  static const String updateConsignmentStatus = "/consignment/status/update";

  // =========================================================
  // PAYMENTS
  // =========================================================
  static const String initiatePayment = "/payment/initiate";
  static const String verifyPayment = "/payment/verify";
  static const String paymentHistory = "/payment/history";
  static const String walletBalance = "/wallet/balance";
  static const String walletRecharge = "/wallet/recharge";

  // =========================================================
  // NOTIFICATIONS
  // =========================================================
  static const String notificationsList = "/notifications/list";
  static const String markAllRead = "/notifications/mark-read";

  // =========================================================
  // RATINGS & FEEDBACK
  // =========================================================
  static const String submitRating = "/rating/submit";
  static const String getRatingCategories = "/rating/categories";

  // =========================================================
  // ADMIN (Driver / Vehicle Verification)
  // =========================================================
  static const String vehicleUploadPhotos = "/driver/vehicle/photos/upload";
  static const String vehicleVerification = "/driver/vehicle/verify";

  // =========================================================
  // INSURANCE
  // =========================================================
  static const String uploadInsurance = "/driver/insurance/upload";
  static const String insuranceStatus = "/driver/insurance/status";

  // =========================================================
  // AI MATCHING ENGINE
  // =========================================================
  static const String aiDriverMatch = "/ai/driver/suggest";
  static const String aiRouteOptimize = "/ai/route/optimize";

  // =========================================================
  // FILE UPLOAD (AWS / Cloudinary)
  // =========================================================
  static const String uploadFile = "/file/upload";
}
