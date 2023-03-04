import 'package:flutter/material.dart';

import '/app/categories/widgets/add_new_category_form.dart';

class AddNewCategoryScreen extends StatelessWidget {
  const AddNewCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, elevation: 0.0),
        body: AddNewCategoryForm());
  }
}
