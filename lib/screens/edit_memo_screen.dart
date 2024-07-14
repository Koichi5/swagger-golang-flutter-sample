// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:swagger_golang_flutter_sample/api/lib/api.dart';

class EditMemoScreen extends StatefulWidget {
  final Memo memo;

  const EditMemoScreen({super.key, required this.memo});

  @override
  // ignore: library_private_types_in_public_api
  _EditMemoScreenState createState() => _EditMemoScreenState();
}

class _EditMemoScreenState extends State<EditMemoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _tagController;
  late List<String> _tags;
  final DefaultApi api = DefaultApi(ApiClient());

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.memo.title);
    _contentController = TextEditingController(text: widget.memo.content);
    _tagController = TextEditingController();
    _tags = widget.memo.tags.toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addTag() {
    setState(() {
      if (_tagController.text.isNotEmpty) {
        _tags.add(_tagController.text);
        _tagController.clear();
      }
    });
  }

  Future<void> _updateMemo() async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedMemo = NewMemo(
          // id: widget.memo.id,
          title: _titleController.text,
          content: _contentController.text,
          tags: _tags,
        );
        await api.memosMemoIdPut(widget.memo.id!, updatedMemo);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('メモが更新されました')),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラーが発生しました: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メモを編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
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
                controller: _contentController,
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
                      controller: _tagController,
                      decoration: const InputDecoration(labelText: 'Add Tag'),
                      onSubmitted: (_) => _addTag(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addTag,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: _tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        onDeleted: () {
                          setState(() {
                            _tags.remove(tag);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateMemo,
                child: const Text('メモを更新'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
