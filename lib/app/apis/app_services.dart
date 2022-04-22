///TODO add license info
///
///
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/authapi.dart';

///[appServices] is a convenience wrapper class for all
/// APIs in the system
class AppServices {
  ///TODO  add all services here for easy access
  ///data base api
  static DbApi dbService = DbApi();
  DbApi get dpApi => dbService;

  ///Auth api
  static AuthApi authApi = AuthApi(FirebaseAuth.instance);

  ///Notifications API
  // static NotificationsApi notificationsApi = NotificationsApi

  ///storageAPI
  // static StorageApi storageApi = StorageApi();

  ///mailMergeApi
  ///static MailMergeApi mailMergeApi= MailMergeApi();
}
