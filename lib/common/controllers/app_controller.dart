import 'package:get/get.dart';

class AppController {
  static String? _accessToken;
  static String? _message;
  static int? _meetingId;
  static int? _participantId;
  static int? _mainUid;
  static String? _role;
  static String? _userName;
  static String? _email;
  static String? _mobile;
  static int? _isVerified;
  static int? _isManager;
  static String? _depName;
  static int? _depId;
  static int? _depVerified;
  static int? _depActive;

  static get depName => _depName;
  static setdepName(value) {
    _depName = value;
  }

  static get depId => _depId;
  static setdepId(value) {
    _depId = value;
  }

  static get depVerified => _depVerified;
  static setdepVerified(value) {
    _depVerified = value;
  }

  static get depActive => _depActive;
  static setdepActive(value) {
    _depActive = value;
  }

  static get isManager => _isManager;
  static setisManager(value) {
    _isManager = value;
  }

  static get isVerified => _isVerified;
  static setisVerified(value) {
    _isVerified = value;
  }

  static get mobile => _mobile;
  static setMobile(value) {
    _mobile = value;
  }

  static get userName => _userName;
  static setUserName(value) {
    _userName = value;
  }

  static get email => _email;
  static setEmail(value) {
    _email = value;
  }

  static get role => _role;
  static setRole(value) {
    _role = value;
  }

  //For meeting Participants list
  static get meetingId => _meetingId;
  static setmeetingId(value) {
    _meetingId = value;
  }

  //for participant id
  static get participantId => _participantId;
  static setParticipantId(value) {
    _participantId = value;
  }

  //For mainUid

  static get mainUid => _mainUid;
  static setMainUid(value) {
    _mainUid = value;
  }

  static get accessToken => _accessToken;
  static setaccessToken(value) {
    _accessToken = value;
  }

  static get message => _message;
  static setmessage(value) {
    _message = value;
  }
}
