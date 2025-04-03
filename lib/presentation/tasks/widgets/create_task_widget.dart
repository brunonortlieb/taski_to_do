import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/core/validators/not_empty_validator.dart';

class CreateTaskWidget extends StatelessWidget {
  final Function(TaskEntity) onCreate;

  const CreateTaskWidget(this.onCreate, {super.key});

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final content = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 26),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: title,
                validator: NotEmptyValidator().validate,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: 'What’s in your mind?',
                  hintStyle: context.textTheme.bodyLarge,
                  prefixIcon:
                      const ImageIcon(AssetImage(ImageAssets.uncheckedIcon)),
                  prefixIconColor: context.colorScheme.onSurfaceVariant,
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 56, maxHeight: 24),
                ),
              ),
              TextFormField(
                controller: content,
                validator: NotEmptyValidator().validate,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: 'Add a note...',
                  hintStyle: context.textTheme.bodyLarge,
                  prefixIcon: const ImageIcon(AssetImage(ImageAssets.noteIcon)),
                  prefixIconColor: context.colorScheme.onSurfaceVariant,
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 56, maxHeight: 24),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    child: const Text('Create'),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      onCreate(
                          TaskEntity(title: title.text, content: content.text));
                      context.pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
