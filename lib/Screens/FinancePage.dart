import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinanceScreen extends StatefulWidget {
  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final _name = TextEditingController();

  final _price = TextEditingController();

  List<String> _fianacesNames = [];

  List<int> _fianacesPrices = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 40),
          child: _fianacesNames.length > 0
              ? ListView.builder(
                  itemCount: _fianacesNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        trailing: Text(
                          _fianacesPrices[index].toString(),
                          style: TextStyle(
                              color: _fianacesPrices[index] > 0
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 15),
                        ),
                        title: Text(_fianacesNames[index]));
                  })
              : Container(),
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
                    setState(() {
                      _fianacesPrices.add(int.parse(_price.text));
                      _fianacesNames.add(_name.text);
                    });
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
