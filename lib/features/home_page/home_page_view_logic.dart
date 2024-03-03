import 'package:gt_hackathon/mock_data/mock_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageViewLogic {
  String userName = '';

  // Fetch the username from shared preferences
  Future<void> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('username') ?? '';
  }

  // get userDetails from mockUserAdditionalData
  Future<Map<String, Object>?> getUserDetails() async {
    await getUserName();
    return mockUserAdditionalData[userName];
  }

  // get user id from userDetails
  Future<int> getUserId() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return 0;
    }
    return userDetails['id'] as int;
  }

  // get user email from userDetails
  Future<String> getUserEmail() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return '';
    }
    return userDetails['email'] as String;
  }

  // get user first name from userDetails
  Future<String> getUserFirstName() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return '';
    }
    return userDetails['firstName'] as String;
  }

  // get user last name from userDetails
  Future<String> getUserLastName() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return '';
    }
    return userDetails['lastName'] as String;
  }

  // get user phone number from userDetails
  Future<String> getUserPhoneNumber() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return '';
    }
    return userDetails['phoneNumber'] as String;
  }

  // get user username from userDetails
  Future<String> getUserUsername() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return '';
    }
    return userDetails['username'] as String;
  }

  // get user profile picture from userDetails
  Future<String> getUserProfilePicture() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return '';
    }
    return userDetails['profilePicture'] as String;
  }

  // get user balance from userDetails
  Future<double> getUserBalance() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return 0.0;
    }
    return userDetails['points'] as double;
  }

  // get user transactions from userDetails
  Future<List<Map<String, Object>>> getUserTransactions() async {
    final userDetails = await getUserDetails();
    if (userDetails == null) {
      return [];
    }
    return userDetails['transactions'] as List<Map<String, Object>>;
  }
}
