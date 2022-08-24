import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String emailUser = '';

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future<void> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? email = pref.getString('email');
    setState(() {
      emailUser = email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference notif = firestore.collection('notifications');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifikasi",
          style: primaryText.copyWith(
            color: Colors.black87,
          ),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: StreamBuilder<QuerySnapshot>(
            stream: notif.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!.docs
                      .where((element) => element['id_supplier'] == emailUser)
                      .map((e) {
                    Map<String, dynamic> notification =
                        e.data() as Map<String, dynamic>;

                    String tgl = DateFormat('dd/MM')
                        .format((notification['date'] as Timestamp).toDate());
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          notif
                              .doc(notification['code'])
                              .update({'isRead': true});
                        });
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Badge(
                                    showBadge: !notification['isRead'],
                                    padding: EdgeInsets.all(8),
                                    badgeContent: Text(
                                      "!",
                                      style: primaryText.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryColor,
                                      ),
                                      child: Icon(
                                        Icons.notifications,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${notification['supplier']}",
                                          style: primaryText.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${notification['title']}",
                                          style: primaryText.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${notification['description']}",
                                          style: primaryText.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text("${tgl}")
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text('No Data'),
                );
              }
            }),
      ),
    );
  }
}
