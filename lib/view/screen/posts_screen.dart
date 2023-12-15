import 'package:flutter/material.dart';
import 'package:portfolioapps/auth/httpservice.dart';
import 'package:portfolioapps/model/post_models.dart';
import 'package:portfolioapps/view/comman/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<PostModel> postList = [];
  bool _enablePullDown = true;
  late RefreshController _refreshController;
  _onLoading() {
    _refreshController.loadComplete();
  }

  Future<void> _onRefresh() async {
    setState(() {
      PostScreen();
      _buildBody();
      _refreshController.refreshCompleted();
    });
  }

  Future<void> getPost() async {
    postList = await HttpService().getPost();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getPost();
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
        onRefresh: _onRefresh,
        child: _buildBody(),
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
            "${postList[index].id}",
            style: TextStyle(color: Colors.black),
          ),
        ));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: postList.length,
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
                        title: Text("${postList[index].title}"),
                        subtitle: Text(
                          "${postList[index].body}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )));
            },
          ),
        ],
      ),
    );
  }
}
