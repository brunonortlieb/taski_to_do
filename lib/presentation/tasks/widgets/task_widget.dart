import 'package:flutter/material.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';

class TaskWidget extends StatefulWidget {
  final TaskEntity data;
  final void Function(TaskEntity) onChanged;
  final void Function(TaskEntity) onDelete;

  const TaskWidget(
    this.data, {
    required this.onChanged,
    required this.onDelete,
    super.key,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  key: const Key('isDnoe'),
                  onPressed: () => widget.onChanged(widget.data.copyWith(isDone: !widget.data.isDone)),
                  icon: ImageIcon(AssetImage(widget.data.isDone ? ImageAssets.checkIcon : ImageAssets.uncheckedIcon)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.data.title,
                    style: context.textTheme.titleSmall,
                  ),
                ),
                const SizedBox(width: 8),
                if (widget.data.isDone)
                  IconButton(
                    key: const Key('delete'),
                    onPressed: () => widget.onDelete(widget.data),
                    icon: ImageIcon(
                      const AssetImage(ImageAssets.deleteIcon),
                      color: context.colorScheme.error,
                    ),
                  )
                else if (isCollapsed)
                  IconButton(
                    key: const Key('more'),
                    onPressed: () => setState(() => isCollapsed = false),
                    icon: const ImageIcon(AssetImage(ImageAssets.dotsIcon)),
                  ),
              ],
            ),
            if (!isCollapsed) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(widget.data.content),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
