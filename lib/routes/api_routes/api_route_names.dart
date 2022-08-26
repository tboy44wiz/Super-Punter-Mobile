/*
* Base URL.2
*/
// const String baseURL = 'https://hepaloop-api.herokuapp.com/api/v1';
// const String baseURL = 'http://10.0.2.2:5000/api/v1'; //  Emulator
// const String baseURL = 'http://192.168.0.143:5000/api/v1'; // AITech WiFi
const String baseURL = 'http://192.168.1.36:5000/api/v1'; // AITech Fibre
// const String baseURL = 'http://192.168.43.245:5000/api/v1'; // Phone WiFi


/*
* Auth API Routes.
*/
const String signUpUserRoute = '/users/signup';
const String loginUserRoute = '/users/login';


/*
* Users API Routes.
*/
const String getSingleUserRoute = '/users/single_user';
const String updateUserRoute = '/users/update_user';
const String updateUserPictureRoute = '/users/upload_user_picture';
const String deleteUserRoute = '/users/delete_user';


/*
* OTP API Routes.
*/
const String sendVerificationOTPRoute = '/otp/send_otp';
const String verifyOTPRoute = '/otp/verify_otp';


/*
* PODCAST API Routes.
*/
const String getAllPodcastsRoute = '/podcasts/get_all_podcasts';
const String getSinglePodcastRoute = '/podcasts/update_single_podcast';


/*
* LIKE Podcast API Routes.
*/
const String createOrDeletePodcastLikeRoute = '/likes/create_or_delete_podcast_like';


/*
* VIEW Podcast API Routes.
*/
const String createPodcastViewRoute = '/views/create_view';