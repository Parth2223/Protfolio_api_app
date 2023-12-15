import 'package:flutter/material.dart';
import 'package:portfolioapps/auth/httpservice.dart';
import 'package:portfolioapps/model/user_login_model.dart';
import 'package:portfolioapps/view/comman/color.dart';
import 'package:portfolioapps/view/comman/style.dart';
import 'package:portfolioapps/view/screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<UserLoginModel> userlist = [];
  List<UserLoginModel> serchlist = [];
  bool isLoading = false;

  Future<void> getuserdata() async {
    if (mounted) {
      isLoading = true;
    }
    setState(() {});
    userlist = await HttpService().getUserLogin();
    serchlist.addAll(userlist);
    if (mounted) {
      isLoading = false;
    }
    setState(() {});
  }

  void search(String list) {
    serchlist = [];
    for (var i in userlist) {
      if (i.name!.contains(list)) {
        serchlist.add(i);
      }
    }
  }

  @override
  void initState() {
    getuserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 48.0, left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchText(),
                    _buildSearchBar(),
                    _buildGridviewBuilder(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSearchText() {
    return Text(
      "Search",
      style: headline1,
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: _buildRowInContainerSearch(),
    );
  }

  Widget _buildRowInContainerSearch() {
    return Row(
      children: <Widget>[
        _buildIconContainer(),
        _buildSearchTextFormField(),
      ],
    );
  }

  Widget _buildIconContainer() {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: facbookColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.person,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSearchTextFormField() {
    return Expanded(
      flex: 5,
      child: TextFormField(
        controller: searchController,
        onChanged: (value) {
          if (searchController.text.trim().isNotEmpty) {
            search(value);
            setState(() {});
          } else {
            search(value);
            setState(() {});
          }
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: black, width: 3),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            hintText: "Search.....",
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget _buildGridviewBuilder() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: serchlist.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: (1 / 1.42),
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            print("on tapped ${index}");
          },
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/car.jpg",
                      fit: BoxFit.fill,
                      height: 110,
                    ),
                    Positioned(
                      top: 85,
                      left: 70,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: white,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/emoji.jpg'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 140,
                      left: 14,
                      right: 14,
                      child: Center(
                        child: Text(
                          "${serchlist[index].name ?? ""}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 158,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Text(
                          "@ ${serchlist[index].website ?? ""}",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 195,
                      left: 10,
                      right: 10,
                      child: Center(
                        child: Text(
                          " Address: ${serchlist[index].address?.street ?? ""} , ${serchlist[index].address?.suite ?? ""} , ${serchlist[index].address?.city ?? ""} , ${serchlist[index].address?.zipcode ?? ""}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 240,
                      left: 90,
                      right: 10,
                      child: Container(
                        height: 25,
                        // width: 90,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileScreen(userlist: serchlist[index]),
                                ));
                          },
                          child: Text(
                            "Profile",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
