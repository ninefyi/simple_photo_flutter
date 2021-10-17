import 'package:flutter/material.dart';
import 'package:mobile/data/models/photo/photo.dart';
import 'package:mobile/modules/home/controller/home_controller.dart';
import 'package:mobile/shares/widget/image_card.dart';
import 'package:mobile/utils/helper.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "/home";

  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _homeController = HomeController();
  bool _isLoading = false;
  List<AllPhoto> _data = [];

  @override
  void initState() {
    setState(() {
      this._isLoading = true;
    });
    this._getPhotos();
    super.initState();
  }

  Future _getPhotos() async {
    final List<AllPhoto> data = await _homeController.getAllPhotos();
    setState(() {
      _data = data;
      _isLoading = false;
    });
  }

  void _onUpload() async {
    // setState(() {
    //   _isLoading = true;
    // });
    await _homeController.onUploadImage(context);
    await this._getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _homeController.navigateToProfile(context),
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getPhotos,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: SingleChildScrollView(
                  child: Center(
                    child: ListView.builder(
                      itemCount: _data.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) => ImageCard(
                        time: Helper().dateTimeConvert(_data[index].updatedAt),
                        img: _data[index].path,
                        name: _data[index].memberName,
                        description: _data[index].name,
                      ),
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onUpload,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
