import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Search',
                  fillColor: Colors.brown,
                  helperText: 'Search any news',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (val) =>
                    val.isEmpty ? 'Please enter any content' : null,
                onChanged: (val) => query = val,
              ),
              SizedBox(height: 20.0),
              FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text('Search', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print(query);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
