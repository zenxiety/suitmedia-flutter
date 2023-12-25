import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_mobile_intern/utils/constants/colors.dart';
import 'package:suitmedia_mobile_intern/utils/constants/loading_states.dart';
import 'package:suitmedia_mobile_intern/viewmodels/second_screen_provider.dart';
import 'package:suitmedia_mobile_intern/viewmodels/third_screen_provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late final ThirdScreenProvider provider;

  @override
  void initState() {
    provider = Provider.of<ThirdScreenProvider>(context, listen: false);
    provider.getUsers();
    provider.scrollController = ScrollController()
      ..addListener(() => provider.loadMoreUsers());
    provider.hasNextPage = true;
    provider.currentPage = 1;
    super.initState();
  }

  @override
  void dispose() {
    provider.scrollController?.removeListener(() => provider.loadMoreUsers());
    provider.scrollController?.dispose();
    provider.userList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Third Screen",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Provider.of<ThirdScreenProvider>(context, listen: false)
                .onBack(context);
            Provider.of<SecondScreenProvider>(context, listen: false)
                .getUserName();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorPalette.blue,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: ColorPalette.gray,
        elevation: .5,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<ThirdScreenProvider>(context, listen: false).getUsers();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Consumer<ThirdScreenProvider>(builder: (context, state, _) {
            return state.fetchUsersLoadingState == LoadingState.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorPalette.teal,
                    ),
                  )
                : state.fetchUsersLoadingState == LoadingState.success
                    ? Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.separated(
                              controller: state.scrollController,
                              itemCount: state.userList.length,
                              itemBuilder: (_, index) {
                                final user = state.userList[index];

                                return GestureDetector(
                                  onTap: () {
                                    state.setUser(
                                      context,
                                      name:
                                          "${user.firstName} ${user.lastName}",
                                    );
                                    Provider.of<SecondScreenProvider>(
                                      context,
                                      listen: false,
                                    ).getUserName();
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(user.avatar),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(9999),
                                      ),
                                    ),
                                    title: Text(
                                      "${user.firstName} ${user.lastName}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      user.email.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: ColorPalette.darkGray,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: Color(0xFFE2E3E4),
                                );
                              },
                            ),
                          ),
                          state.loadMoreLoadingState == LoadingState.loading
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: ColorPalette.teal),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      )
                    : state.fetchUsersLoadingState == LoadingState.failed ||
                            state.userList.isEmpty
                        ? const Center(
                            child: Text(
                              "Users Not Found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : const SizedBox();
          }),
        ),
      ),
    );
  }
}
