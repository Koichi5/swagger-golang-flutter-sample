import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swagger_golang_flutter_sample/api/lib/api.dart';
import 'package:swagger_golang_flutter_sample/screens/state/memo_controller.dart';

class CreateMemoScreen extends HookConsumerWidget {
  const CreateMemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final tagController = useTextEditingController();
    final tags = useState<List<String>>([]);

    void addTag() {
      if (tagController.text.isNotEmpty) {
        tags.value = [...tags.value, tagController.text];
        tagController.clear();
      }
    }

    Future<void> createMemo() async {
      if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
        final newMemo = NewMemo(
          title: titleController.text,
          content: contentController.text,
          tags: tags.value,
        );

        await ref.read(memoControllerProvider.notifier).createMemo(newMemo);
        Navigator.pop(context, true);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規メモ作成'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'タイトル'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: '内容'),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tagController,
                    decoration: const InputDecoration(labelText: 'タグ'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addTag,
                ),
              ],
            ),
            Wrap(
              spacing: 8.0,
              children: tags.value.map((tag) => Chip(
                label: Text(tag),
                onDeleted: () {
                  tags.value = tags.value.where((t) => t != tag).toList();
                },
              )).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: createMemo,
              child: const Text('メモを作成'),
            ),
          ],
        ),
      ),
    );
  }
}