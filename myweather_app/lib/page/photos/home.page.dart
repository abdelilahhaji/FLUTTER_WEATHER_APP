import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosPage extends StatefulWidget {
  String previewUrl;
  PhotosPage(this.previewUrl);
  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photos'),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.previewUrl),
          )
        ],
      ),
      drawer: Drawer(),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}