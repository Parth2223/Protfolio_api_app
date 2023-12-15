import 'package:flutter/material.dart';
import 'package:portfolioapps/auth/httpservice.dart';
import 'package:portfolioapps/model/photos+model.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<PhotosModel> photoslist = [];
  bool isLoading = false;

  Future<void> getPhoto() async {
    photoslist = await HttpService().getPhoto();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getPhoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(children: [
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: photoslist.length,
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
                            child: Column(
                              children: [
                                Image.network(
                                  "${photoslist[index].url}",
                                  fit: BoxFit.fill,
                                  height: 110,
                                ),
                                Text("${photoslist[index].title}")
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]),
            ),
    );
  }
}
