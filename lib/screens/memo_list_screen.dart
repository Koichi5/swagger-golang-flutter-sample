import 'package:flutter/material.dart';
import 'package:swagger_golang_flutter_sample/api/lib/api.dart';
import 'package:swagger_golang_flutter_sample/screens/create_memo_screen.dart';
import 'package:swagger_golang_flutter_sample/screens/edit_memo_screen.dart';

class MemoListScreen extends StatefulWidget {
  const MemoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  // final ApiClient api = ApiClient();
  final DefaultApi api = DefaultApi(ApiClient());
  List<Memo> memos = [];

  @override
  void initState() {
    super.initState();
    _fetchMemos();
  }

Future<void> _fetchMemos() async {
  try {
    final fetchedMemos = await api.memosGet();
    setState(() {
      memos = fetchedMemos ?? [];
    });
    // デバッグ出力を追加
    for (var memo in memos) {
      print('Memo ID: ${memo.id}, Title: ${memo.title}');
    }
  } catch (e) {
    print('Error fetching memos: $e');
  }
}

  Future<void> _deleteMemo(String memoId) async {
    try {
      await api.memosMemoIdDelete(memoId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('メモが削除されました')),
      );
      setState(() {
        memos.removeWhere((memo) => memo.id == memoId);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memos'),
      ),
      body: ListView.builder(
        itemCount: memos.length,
        itemBuilder: (context, index) {
          final memo = memos[index];
          if (memo.id == null) {
            return ListTile(
              title: Text(memo.title ?? ''),
              subtitle: Text(memo.content ?? ''),
            );
          }
          return Dismissible(
            key: Key(memo.id ?? ''),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              _deleteMemo(memo.id!);
            },
            child: ListTile(
              title: Text(memo.title ?? ''),
              subtitle: Text(memo.content ?? ''),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditMemoScreen(memo: memo),
                  ),
                );
                if (result == true) {
                  _fetchMemos(); // リストを更新
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateMemoScreen(),
            ),
          );
          if (result != null) {
            _fetchMemos(); // メモリストを更新
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
