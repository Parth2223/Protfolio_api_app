import 'package:flutter/material.dart';
import 'package:portfolioapps/auth/httpservice.dart';
import 'package:portfolioapps/model/todos_model.dart';
import 'package:portfolioapps/model/user_login_model.dart';
import 'package:portfolioapps/view/comman/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  List<TodosModel> todoslist = [];
  List<UserLoginModel> userlist = [];
  bool _enablePullDown = true;
  late RefreshController _refreshController;
  bool isLoading = false;
  _onLoading() {
    _refreshController.loadComplete();
  }

  Future<void> _onRefreshh() async {
    setState(() {
      TodosScreen();
      _buildListTodos();
      _refreshController.refreshCompleted();
    });
  }

  Future<void> getTodos() async {
    todoslist = await HttpService().getTodos();
    if (mounted) setState(() {});
  }

  Future<void> getuserdata() async {
    userlist = await HttpService().getUserLogin();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getTodos();
    getuserdata();
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: _enablePullDown,
        header: WaterDropHeader(
          waterDropColor: MainColor,
        ),
        onLoading: _onLoading,
        onRefresh: _onRefreshh,
        child: _buildListTodos(),
      ),
    );
  }

  Widget _buildProductImage(index) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        height: double.infinity,
        width: 60,
        child: CircleAvatar(
          backgroundColor: Colors.black26,
          child: Text(
            "${todoslist[index].id}",
            style: TextStyle(color: Colors.black),
          ),
        ));
  }

  Widget _buildListTodos() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: todoslist.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: _buildProductImage(index),
                        title: Text("${todoslist[index].title}"),
                        subtitle: Text("${todoslist[index].completed}"),
                      )));
            },
          ),
        ],
      ),
    );
  }
}
