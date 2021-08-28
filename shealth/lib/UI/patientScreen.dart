import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xffF3F1F5),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
          backgroundColor: Color(0xffb793da),
        ),
        appBar: AppBar(
          title: Text('Shealth'),
          backgroundColor: Color(0xffb793da),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color(0xff49484b),
            
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