import 'package:flutter/material.dart';
import 'package:portfolioapps/auth/httpservice.dart';
import 'package:portfolioapps/model/albums_model.dart';
import 'package:portfolioapps/view/comman/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  List<AlbumsModel> albumList = [];
  bool _enablePullDown = true;
  late RefreshController _refreshController;
  _onLoading() {
    _refreshController.loadComplete();
  }

  Future<void> _onRefreshh() async {
    setState(() {
      AlbumScreen();
      _buildBody();
      _refreshController.refreshCompleted();
    });
  }

  Future<void> getAlbumData() async {
    albumList = await HttpService().getAlbums();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getAlbumData();
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
            "${albumList[index].id}",
            style: TextStyle(color: Colors.black),
          ),
        ));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: albumList.length,
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
                        title: Text("${albumList[index].title}"),
                      )));
            },
          ),
        ],
      ),
    );
  }
}
