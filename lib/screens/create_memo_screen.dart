import 'package:flutter/material.dart';
import 'package:swagger_golang_flutter_sample/api/lib/api.dart';

class CreateMemoScreen extends StatefulWidget {
  @override
  _CreateMemoScreenState createState() => _CreateMemoScreenState();
}

class _CreateMemoScreenState extends State<CreateMemoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagController = TextEditingController();
  List<String> _tags = [];
  final DefaultApi api = DefaultApi(ApiClient());

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

  Future<void> _createMemo() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newMemo = NewMemo(
          title: _titleController.text,
          content: _contentController.text,
          tags: _tags, // Use the _tags list instead of [_tagController.text]
        );
        final createdMemo = await api.memosPost(newMemo);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('メモが作成されました')),
        );
        Navigator.pop(context, createdMemo);
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
        title: const Text('新規メモ作成'),
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
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tagController,
                      decoration: InputDecoration(labelText: 'Add Tag'),
                      onSubmitted: (_) => _addTag(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addTag,
                  ),
                ],
              ),
              Wrap(
                spacing: 8.0,
                children: _tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          onDeleted: () {
                            setState(() {
                              _tags.remove(tag);
                            });
                          },
                        ))
                    .toList(),
              ),
              ElevatedButton(
                onPressed: _createMemo,
                child: const Text('メモを作成'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}