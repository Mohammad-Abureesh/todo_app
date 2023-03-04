import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final AsyncCallback? onShare;
  const ShareButton({Key? key, this.onShare}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onShare, icon: const Icon(Icons.share));
  }
}
