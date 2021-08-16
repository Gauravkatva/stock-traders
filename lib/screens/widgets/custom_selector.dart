import 'package:flutter/material.dart';

class CustomSelector extends StatefulWidget {
  CustomSelector({Key? key, required this.onChanged}) : super(key: key);
  final Function(String) onChanged;
  @override
  _CustomSelectorState createState() => _CustomSelectorState();
}

class _CustomSelectorState extends State<CustomSelector> {
  final _list = ["NSE", "BSE"];
  int _pointer = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Exchange",
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: List.generate(_list.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _pointer = index;
                  });
                  widget.onChanged(_list[index]);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    color: index == _pointer ? Colors.indigo : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    "${_list[index]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: index == _pointer ? Colors.white : Colors.indigo,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
