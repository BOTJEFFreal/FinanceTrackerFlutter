import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FinanceScreen extends StatefulWidget {
  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final _name = TextEditingController();
  final _price = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  addFinances(String name, String price) async {
    print(name);
    print(price);
    Map<String, dynamic> messages = {
      "name": name,
      "price": price,
      "time": FieldValue.serverTimestamp(),
    };

    await _firestore
          .collection('Finances')
          .doc(_auth.currentUser!.displayName!)
          .collection('Paid')
          .add(messages);

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('Finances')
                    .doc(_auth.currentUser!.displayName!)
                    .collection('Paid')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return message(size, map);
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          )


        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size.width * 0.4,
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                width: size.width * 0.2,
                child: TextField(
                  controller: _price,
                  decoration: InputDecoration(
                      hintText: "Price",
                      hintStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    addFinances(_name.text,_price.text);

                    _name.clear();
                    _price.clear();
                  },
                  child: Container(
                      child: Text(
                    "+",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}

Widget message(Size size, Map<String, dynamic> map) {

  return ListTile(
      trailing: Text(
        map['price'].toString(),
        style: TextStyle(
            color: int.parse(map['price'])  > 0
                ? Colors.green
                : Colors.red,
            fontSize: 15),
      ),
      title: Text(map['name']));
}

