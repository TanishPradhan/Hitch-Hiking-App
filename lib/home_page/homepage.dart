import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hitch_hiking/data/user_dao.dart';
import 'package:hitch_hiking/global_widgets/text_global.dart';
import 'package:hitch_hiking/login_page.dart';
import 'package:hitch_hiking/profile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  late DatabaseReference _dbref;
  final TextEditingController carNo = TextEditingController();
  int rideNo = 1;
  int seatsAvailable = 0;
  String dropDownValueFrom = 'Ujjain';
  String dropDownValueTo = 'Indore';
  String name = "";
  String profileURL = "";
  String carNumber = "";
  TimeOfDay selectedTime = TimeOfDay.now();
  String nameArr = new List.generate(10, (index) => 0) as String;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
    _database();
  }

  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: false);
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
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Sign out',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  userDao.logout();
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.grey.shade400,
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 80 / 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: DropdownButtonFormField(
                            value: dropDownValueFrom,
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValueFrom = newValue!;
                              });
                            },
                            items: <String>['Ujjain', 'Indore']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     Text(
                          //       'From',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     Icon(Icons.arrow_drop_down_sharp),
                          //   ],
                          // ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 80 / 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: DropdownButtonFormField(
                            value: dropDownValueTo,
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValueTo = newValue!;
                              });
                            },
                            items: <String>['Ujjain', 'Indore']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 80 / 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            controller: carNo,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Car Number',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 80 / 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Time:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  "${selectedTime.hour}:${selectedTime.minute}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Seat Availability',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    seatsAvailable--;
                                  });
                                },
                                child: Icon(Icons.remove),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    seatsAvailable.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    seatsAvailable++;
                                  });
                                },
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: TextButton(
                              onPressed: () {
                                //_createDB();
                                _readDB();
                                //carNumber = carNo;
                                //Navigator.of(context).pop();
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                scrollable: true,
              ),
            );
          },
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.only(
                            left: 5,
                          ),
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Booking Details'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Name:'),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          'Tanish Pradhan',
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Trip:'),
                                        SizedBox(
                                          width: 22.0,
                                        ),
                                        Text(
                                          'Ujjain - Indore',
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Time:'),
                                        SizedBox(
                                          width: 13.0,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 22.0,
                                          width: 80.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            color: Colors.grey.withOpacity(0.7),
                                          ),
                                          child: Text(
                                            '10:00 AM',
                                            style: TextStyle(
                                              color: Colors.black87
                                                  .withOpacity(0.8),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 125.0,
                                          alignment: Alignment.center,
                                          height: 35.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: Text(
                                            'Seat Availability',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {},
                                              child: Icon(Icons.add),
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 40.0,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0,
                                                    right: 12.0,
                                                    top: 8.0,
                                                    bottom: 8.0),
                                                child: Text(
                                                  '0',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                scrollable: true,
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text(
                                      'Book',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          leading: Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            child: CircleAvatar(
                              radius: 23.0,
                              backgroundImage: (user!.photoURL == null)
                                  ? null
                                  : NetworkImage(user!.photoURL.toString()),
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

  _database() {
    setState(() {
      name = user!.displayName!;
      profileURL = user!.photoURL!;
    });
  }

  _createDB() {
    carNumber = carNo.text.trim();

    _dbref.child("Ride $rideNo").set({
      "Name": "$name",
      "ProfileURL": "$profileURL",
      "From": "$dropDownValueFrom",
      "To": "$dropDownValueTo",
      "Car No": "$carNumber",
      "Time": "${selectedTime.hour}:${selectedTime.minute}",
      "Seats Available": "$seatsAvailable"
    });
  }

  _readDB() {
    for (int i = 0; i < rideNo; i++) {
      _dbref
          .child("Ride $rideNo")
          .child("Name")
          .once()
          .then((DataSnapshot dataSnapshot) {
        print(dataSnapshot.value.toString());
        setState(() {
          //nameArr[i] = dataSnapshot.value.toString();
        });
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
