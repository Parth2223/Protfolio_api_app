import 'package:flutter/material.dart';

import 'package:portfolioapps/model/user_login_model.dart';
import 'package:portfolioapps/view/comman/color.dart';
import 'package:portfolioapps/view/screen/albums_screen.dart';
import 'package:portfolioapps/view/screen/posts_screen.dart';
import 'package:portfolioapps/view/screen/todos.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, this.userlist});
  final UserLoginModel? userlist;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    // backgroundColor: MainColor,
                    title: InkWell(
                      child: CircleAvatar(
                        backgroundColor: Colors.black26,
                        child: Icon(Icons.arrow_back_ios_new, color: white),
                      ),
                    ),
                    actions: [
                      _buildprofileimg(),
                      SizedBox(width: 5),
                      _buildSearch(),
                      SizedBox(width: 5),
                      _buildPopupmenu(),
                      SizedBox(width: 5),
                    ],
                    pinned: true,
                    expandedHeight: 250.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          _buildBackgroundimg(),
                          _buildCircleAvtarimg(),
                          _buildNameANdButtonRow(),
                          _buildemail(),
                          _buildCatchphase(),
                          _buildCompanyDetails(),
                        ],
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(TabBar(
                      indicatorColor: Colors.white,
                      labelStyle: TextStyle(fontWeight: FontWeight.w600),
                      labelColor: Colors.white,
                      labelPadding: EdgeInsets.all(8),
                      unselectedLabelColor: Colors.white,
                      controller: _tabController,
                      tabs: [
                        Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              color: facbookColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Tab(text: 'Todos'),
                        ),
                        Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              color: facbookColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Tab(text: 'Albums'),
                        ),
                        Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              color: facbookColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Tab(text: 'Post'),
                        ),
                        // Tab(text: 'Photos'),
                      ],
                    )),
                  ),
                ];
              },
              body: TabBarView(
                physics: ClampingScrollPhysics(),
                controller: _tabController,
                children: [
                  TodosScreen(),
                  AlbumScreen(),
                  PostScreen(),
                  // Center(child: PhotosScreen()),
                ],
              ),
            ),
    );
  }

  PopupMenuItem PopupMenuPosition(String title) {
    return PopupMenuItem(
        onTap: () {},
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buildprofileimg() {
    return CircleAvatar(
      backgroundColor: Colors.black26,
      child: Icon(Icons.qr_code_scanner, color: white),
    );
  }

  Widget _buildSearch() {
    return CircleAvatar(
      backgroundColor: Colors.black26,
      child: Icon(Icons.search, color: white),
    );
  }

  Widget _buildPopupmenu() {
    return CircleAvatar(
      backgroundColor: Colors.black26,
      child: PopupMenuButton(
          color: white,
          itemBuilder: (ctx) => [
                PopupMenuPosition('Product'),
              ]),
    );
  }

  Widget _buildBackgroundimg() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://media.istockphoto.com/id/1290692464/photo/teamwork-network-and-community-concept.jpg?s=612x612&w=0&k=20&c=mfmO8j68TjNnoGki0UJe58SKfqyNgIp3lHDSJ0OkVo0="),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 110,
            ),
            Text(
              'Its only a crazy dream until you do it.',
              style: TextStyle(
                color: black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleAvtarimg() {
    return Positioned(
      top: 115,
      left: 20,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: white,
        child: CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('assets/images/parthpro.jpg'),
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      "${widget.userlist?.name ?? ""}",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Widget _buildFollowingButton() {
    return Container(
      height: 25,
      // width: 90,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Following",
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  Widget _buildNameANdButtonRow() {
    return Positioned(
      top: 164,
      left: 5,
      child: Row(
        children: [
          _buildName(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.45),
          _buildFollowingButton(),
        ],
      ),
    );
  }

  Widget _buildemail() {
    return Positioned(
      top: 183,
      left: 5,
      child: Center(
        child: Text(
          "${widget.userlist?.email ?? ""}",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildCatchphase() {
    return Positioned(
      top: 220,
      left: 10,
      right: 10,
      child: Center(
        child: Text(
          "${widget.userlist?.company?.catchPhrase ?? ""}",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildCompanyName() {
    return Text(
      "Company: ${widget.userlist?.company?.name ?? ""}",
      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
    );
  }

  Widget _buildPhoneNumber() {
    return Text(
      "Phone: ${widget.userlist?.phone}",
      style: TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 13),
    );
  }

  Widget _buildWebsite() {
    return Text(
      "Website: ${widget.userlist?.website}",
      style: TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 13),
    );
  }

  Widget _buildCompanyDetails() {
    return Positioned(
      top: 250,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCompanyName(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildPhoneNumber(), _buildWebsite()],
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
