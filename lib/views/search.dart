import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:flutter_messenger/controllers/search_controller.dart';
import 'package:flutter_messenger/services/databases.dart';
import 'package:flutter_messenger/views/chat.dart';
import 'package:get/get.dart';

class Search extends SearchDelegate<String> {
  SearchController searchController = Get.find<SearchController>();
  AuthController authController = Get.find<AuthController>();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      CupertinoButton(
        child: Icon(
          Icons.clear,
        ),
        onPressed: () {
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.green,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (searchController == null ||
        searchController.getListUser == null ||
        searchController.getListUser.length == 0) {
      return Container(
        child: Center(
          child: Text('Not found'),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: searchController.getListUser.length,
        itemBuilder: (_, index) {
          return ListTile(
            onTap: () {
              Get.off(
                () => ChatScreen(),
                arguments: searchController.getListUser[index],
              );
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(searchController.getListUser[index].photoUrl),
            ),
            title: Text(searchController.getListUser[index].name),
            subtitle: Text(searchController.getListUser[index].email),
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Obx(
      () {
        searchController.listUser.bindStream(DatabaseMethods().getUserByUserName(query));
        if (searchController == null ||
            searchController.getListUser == null ||
            searchController.getListUser.length == 0) {
          return Container(
            child: Center(
              child: Text('Not found'),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: searchController.getListUser.length,
            itemBuilder: (_, index) {
              return ListTile(
                onTap: () {
                  Get.off(
                    () => ChatScreen(),
                    arguments: searchController.getListUser[index],
                  );
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      searchController.getListUser[index].photoUrl,
                    ),
                  ),
                ),
                title: Text(searchController.getListUser[index].name),
                subtitle: Text(searchController.getListUser[index].email),
              );
            },
          );
        }
      },
    );
  }

  @override
  String get searchFieldLabel => "Type user name here...";
}
