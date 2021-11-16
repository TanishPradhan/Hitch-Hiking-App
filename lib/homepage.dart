import 'package:flutter/material.dart';
import 'package:hitch_hiking/global_widgets/text_global.dart';
import 'package:hitch_hiking/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notifications,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.account_circle,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Profile()));
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Hi User!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Profile(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Setting',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  color: Colors.greenAccent,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 5,
                        ),
                        onTap: () {},
                        leading: Padding(
                          padding: const EdgeInsets.only(
                            left: 5.0,
                          ),
                          child: CircleAvatar(
                            radius: 23.0,
                            //backgroundImage: AssetImage(USERDUMMY),
                            backgroundColor: Colors.white,
                            /* NetworkImage("${snapshot.data.hitsList[index].previewUrl}"),*/
                          ),
                        ),
                        title: TextType(
                          text: 'Tanish Pradhan',
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                        ),
                        subtitle: Text(
                          'Ujjain - Indore',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Time: 10:00 AM',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Seats: 3',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              padding: EdgeInsets.all(2.0),
            ),
          ),
        ),
      ),
    );
  }
}
