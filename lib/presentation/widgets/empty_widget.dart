import 'package:flutter/material.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';

class EmptyListWidget extends StatelessWidget {
  final void Function()? onCreate;

  const EmptyListWidget({this.onCreate, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImageAssets.empty, height: 80),
        const SizedBox(height: 24),
        Text(
            onCreate == null ? 'No result found.' : 'You have no task listed.'),
        if (onCreate != null) ...[
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: onCreate,
            icon: const ImageIcon(AssetImage(ImageAssets.addIcon)),
            label: const Text('Create task'),
          )
        ],
      ],
    );
  }
}
