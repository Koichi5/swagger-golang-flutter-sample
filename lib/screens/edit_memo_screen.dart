import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swagger_golang_flutter_sample/api/lib/api.dart';
import 'package:swagger_golang_flutter_sample/screens/state/memo_controller.dart';

class EditMemoScreen extends HookConsumerWidget {
  final Memo memo;

  const EditMemoScreen({
    super.key,
    required this.memo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final titleController = useTextEditingController(text: memo.title);
    final contentController = useTextEditingController(text: memo.content);
    final tagController = useTextEditingController();
    final tags = useState<List<String>>(memo.tags.toList());

    void addTag() {
      if (tagController.text.isNotEmpty) {
        tags.value = [...tags.value, tagController.text];
        tagController.clear();
      }
    }

    Future<void> updateMemo() async {
      if (formKey.currentState!.validate()) {
        try {
          final updatedMemo = NewMemo(
            title: titleController.text,
            content: contentController.text,
            tags: tags.value,
          );
          await ref
              .read(memoControllerProvider.notifier)
              .updateMemo(memo.id!, updatedMemo);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('メモが更新されました')),
            );
            Navigator.pop(context, true);
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('エラーが発生しました: $e')),
            );
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('メモを編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'タイトル'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'タイトルを入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(labelText: '内容'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '内容を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: tagController,
                      decoration: const InputDecoration(labelText: 'Add Tag'),
                      onSubmitted: (_) => addTag(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: addTag,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: tags.value
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        onDeleted: () {
                          tags.value =
                              tags.value.where((t) => t != tag).toList();
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: updateMemo,
                child: const Text('メモを更新'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
