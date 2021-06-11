import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myweather_app/page/repositories/home.page.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String query;
  bool notVisible = false;
  dynamic data;
  List<dynamic> items = [];

  TextEditingController queryTextEditingController = new TextEditingController();
  int currentPage = 0;
  int pageSize = 20;
  int totalPages = 0;
  ScrollController scrollController = new ScrollController();

  void _search(String query) {
    String url;
    url =
    "https://api.github.com/search/users?q=${query}&per_page=$pageSize&page=$currentPage";
    http.get(url)
        .then((response) {
      setState(() {
        this.data = json.decode(response.body);
        this.items.addAll(data['items']);
        if (data['total_count'] % pageSize == 0) {
          totalPages = data['total_count'] / pageSize;
        }
        else
          totalPages = (data['total_count'] / pageSize).floor() + 1;
      });
    })
        .catchError((err) {
      print(err);
    })
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          setState(() {
            ++currentPage;
            _search(query);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Users => ($query) => $currentPage / $totalPages'),),
      drawer: Drawer(),
      body: Center(
          child: Column(
              children: [
          Row(
          children: [
          Expanded(
          child: Container(
              padding: EdgeInsets.all(10),
          child: TextFormField(
              obscureText: notVisible,
              onChanged: (value) {
                setState(() {
                  this.query = value;
                });
              },
              controller: queryTextEditingController;
              decoration: InputDecoration(
              icon: Icon(Icons.logout),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                notVisible = !notVisible;
              });
            },
            icon: Icon(
                notVisible == true ? Icons.visibility_off : Icons.visibility),
          ),
          contentPadding: EdgeInsets.only(left: 35),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                  width: 1, color: Colors.deepOrange
              )
          )
      ),
    )),
    ),
    IconButton(
    icon: Icon(Icons.search, color:Colors.deepOrange),
    onPressed: (){
    setState(() {
    items=[];
    currentPage=0;
    this.query=queryTextEditingController.text;
    _search(query);
    });
    }),
    ]
    ),


    Expanded(
    child: ListView.separated(
    separatorBuilder: (context, index) => Divider(height: 2, color: Colors.deepOrange,),
    controller: scrollController,
    itemCount: items.length,
    itemBuilder: (context, index){
    return ListTile(
    onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GitRepositoriesPage(login: items[index]['login'],
    avatarUrl:items[index]['avatar_url'] ,
    )));
    },
    title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Row(
    children:[
    CircleAvatar(
    backgroundImage:NetworkImage(items[index]['avatar_url']),
    radius: 40,
    ),
    SizedBox(width: 20,),
    Text("${items[index]['login']}"),

    ],
    ),
    CircleAvatar(
    child: Text("${items[index]['score']}"),
    )
    ],
    ),
    );
    }
    ),
    ),
    ]
    )
    )
    );

    }
}

