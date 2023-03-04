import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  ///To display empty state
  ///empty list widget
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const path = 'assets/images/empty_list.png';
    return Center(child: Image.asset(path, height: 300.0, width: 300.0));
  }
}
