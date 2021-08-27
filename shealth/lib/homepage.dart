import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Shealth'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Prescriptions',),
              Tab(text: 'Reports',),
              Tab(text: 'Doctors',)
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(child: Center(child: Text('Prescriptions')),),
          Container(child: Center(child: Text('Reports')),),
          Container(child: Center(child: Text('Doctors')),),
        ]),
      ),
    );
  }
}