import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suitmedia_mobile_intern/models/users_model.dart';
import 'package:suitmedia_mobile_intern/services/users_service.dart';
import 'package:suitmedia_mobile_intern/utils/constants/loading_states.dart';
import 'package:suitmedia_mobile_intern/utils/constants/prefs_keys.dart';

class ThirdScreenProvider with ChangeNotifier {
  ScrollController? scrollController;

  LoadingState fetchUsersLoadingState = LoadingState.initial;
  LoadingState loadMoreLoadingState = LoadingState.initial;

  final List<UsersDatum> userList = [];

  late bool hasNextPage;
  late int currentPage;

  void getUsers() async {
    try {
      fetchUsersLoadingState = LoadingState.loading;
      currentPage = 1;
      hasNextPage = true;
      userList.clear();

      final UsersModel? users = await UsersService.getUsers(page: 1);

      userList.addAll(users!.data);
      currentPage++;

      fetchUsersLoadingState = LoadingState.success;
      notifyListeners();
    } catch (_) {
      fetchUsersLoadingState = LoadingState.failed;
      notifyListeners();
    }
  }

  void setUser(BuildContext context, {required String name}) async {
    try {
      fetchUsersLoadingState = LoadingState.loading;
      notifyListeners();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(PrefsKeys.user, name);

      fetchUsersLoadingState = LoadingState.success;
      notifyListeners();
    } catch (_) {
      fetchUsersLoadingState = LoadingState.failed;
      notifyListeners();
    }

    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  void onBack(BuildContext context) async {
    try {
      fetchUsersLoadingState = LoadingState.loading;
      notifyListeners();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(PrefsKeys.user);

      fetchUsersLoadingState = LoadingState.success;
      notifyListeners();
    } catch (_) {
      fetchUsersLoadingState = LoadingState.failed;
      notifyListeners();
    }

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void loadMoreUsers() async {
    if (hasNextPage &&
        loadMoreLoadingState != LoadingState.loading &&
        scrollController!.position.pixels ==
            scrollController!.position.maxScrollExtent) {
      try {
        loadMoreLoadingState = LoadingState.loading;
        notifyListeners();

        final UsersModel? users =
            await UsersService.getUsers(page: currentPage);

        if (users!.data.isNotEmpty) {
          userList.addAll(users.data);
          currentPage++;
        } else {
          hasNextPage = false;
        }

        loadMoreLoadingState = LoadingState.success;
        notifyListeners();
      } catch (_) {
        loadMoreLoadingState = LoadingState.failed;
        notifyListeners();
      }
    }
  }
}
