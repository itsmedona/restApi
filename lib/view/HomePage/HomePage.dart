import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rest_api/model/User/User.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          // final name = user.name;
          //final email = user.email;
          final color = user.gender == 'male'
              ? Colors.lightGreenAccent
              : Colors.deepPurpleAccent;
          //final imageUrl = user['picture']['thumbnail'];
          return ListTile(
            title: Text(user.name.first),
            subtitle: Text(user.phone),
            tileColor: color,
            //subtitle: Text(email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Future<void> fetchUsers() async {
    print('fetchUsers called');
    const url = 'https://randomuser.me/api/?results=10';
    final response = await http.get(Uri.parse(url));
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']);
      return User(
          gender: e['gender'],
          email: e['email'],
          phone: e['phone'],
          cell: e['cell'],
          nat: e['nat'],
          name: name);
    }).toList();
    setState(() {
      users = transformed;
      //users = json['results'];
    });
    print('fetchUsers completed');
  }
}
