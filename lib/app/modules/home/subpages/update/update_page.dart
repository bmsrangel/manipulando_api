import 'dart:async';

import 'package:dio_custom/app/modules/home/subpages/update/update_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../shared/models/post_model.dart';
import '../../home_module.dart';

class UpdatePage extends StatefulWidget {
  final String title;
  final Function onSucess;
  final PostModel snapshot;
  const UpdatePage(
      {Key key, this.title = "Update", this.onSucess, @required this.snapshot})
      : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateBloc bloc = HomeModule.to.bloc<UpdateBloc>();

  Controller controller = Controller();

  @override
  void initState() {
    bloc.id = widget.snapshot.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: StreamBuilder<int>(
        stream: bloc.responseOut,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(
                "${snapshot.error}",
              ),
            );

          if (snapshot.hasData) {
            if (snapshot.data == 0) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Timer(Duration(seconds: 1), () {
                widget.onSucess();
                Navigator.pop(context);
              });
              return Center(
                child: Text("Atualizado com sucesso!"),
              );
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          initialValue: widget.snapshot.title,
                          onSaved: (value) => bloc.title = value,
                          validator: (value) => value.isEmpty
                              ? "O título não pode ser nulo"
                              : null,
                          decoration: InputDecoration(labelText: "Title"),
                        ),
                        TextFormField(
                          initialValue: widget.snapshot.body,
                          onSaved: (value) => bloc.body = value,
                          validator: (value) =>
                              value.isEmpty ? "O body não pode ser nulo" : null,
                          maxLines: 3,
                          decoration: InputDecoration(labelText: "Body"),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Enviar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (controller.validate()) {
                        bloc.postIn.add(PostModel(
                            body: bloc.body, title: bloc.title, userId: 1));
                      }
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class Controller {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate() {
    FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
