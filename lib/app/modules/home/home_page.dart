import 'package:dio_custom/app/modules/home/home_bloc.dart';
import 'package:dio_custom/app/modules/home/home_module.dart';
import 'package:dio_custom/app/modules/home/subpages/create/create_page.dart';
import 'package:dio_custom/app/shared/models/post_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc = HomeModule.to.bloc<HomeBloc>();

  @override
  void initState() {
    super.initState();
    bloc.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<PostModel>>(
          initialData: <PostModel>[],
          stream: bloc.responseOut,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.hasData) {
              return Column(
                children: snapshot.data
                    .map<ListTile>((item) => ListTile(title: Text(item.title)))
                    .toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreatePage(
                        onSucess: bloc.getPosts,
                      )));
        },
      ),
    );
  }
}
