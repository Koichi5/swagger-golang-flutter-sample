import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:swagger_golang_flutter_sample/api/lib/api.dart';
import 'package:swagger_golang_flutter_sample/screens/create_memo_screen.dart';
import 'package:swagger_golang_flutter_sample/screens/detail_memo_screen.dart';
import 'package:swagger_golang_flutter_sample/screens/edit_memo_screen.dart';

class MemoListScreen extends StatefulWidget {
  const MemoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  final DefaultApi api = DefaultApi(ApiClient());
  List<Memo> memos = [];
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchMemos();
  }

  Future<void> _fetchMemos() async {
    try {
      final fetchedMemos = await api.memosGet();
      setState(() {
        memos = fetchedMemos?.toList() ?? [];
      });
    } catch (e) {
      print('Error fetching memos: $e');
    }
  }

  Future<void> _deleteMemo(Memo memo) async {
    try {
      await api.memosMemoIdDelete(memo.id.toString());
      setState(() {
        memos = memos.where((m) => m.id != memo.id).toList(); // 新しいリストを作成
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('メモが削除されました')),
      );
    } catch (e) {
      print('Error deleting memo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('メモの削除に失敗しました')),
      );
    }
  }

  Future<void> _searchMemos(String keyword) async {
    try {
      final searchedMemos = await api.memosSearchGet(keyword);
      setState(() {
        memos = searchedMemos ?? [];
      });
    } catch (e) {
      print('Error searching memos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Memos',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _fetchMemos();
                    _searchController.clear();
                  },
                ),
              ),
              onSubmitted: (value) {
                _searchMemos(value);
              },
              onChanged: (value) {
                _searchMemos(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memo = memos[index];
                if (memo.id == null) {
                  return ListTile(
                    title: Text(memo.title ?? ''),
                    subtitle: Column(
                      children: [
                        Text(memo.content ?? ''),
                        const Gap(8),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: (memo.tags)
                              .map((tag) => Chip(
                                    label: Text(tag),
                                    backgroundColor: Colors.blue.shade100,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
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
                }
                return Dismissible(
                  key: Key(memo.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    final deletedMemo = memo;
                    setState(() {
                      memos = List.from(memos)
                        ..removeAt(index); // 新しいリストを作成して要素を削除
                    });
                    _deleteMemo(deletedMemo).then((_) {
                      // 削除が成功した場合の処理（必要に応じて）
                    }).catchError((error) {
                      // 削除が失敗した場合、メモをリストに戻す
                      setState(() {
                        memos.insert(index, deletedMemo);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('メモの削除に失敗しました')),
                      );
                    });
                  },
                  child: ListTile(
                    title: Text(memo.title ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(memo.content ?? ''),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: (memo.tags)
                              .map((tag) => Chip(
                                    label: Text(
                                      tag,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    backgroundColor: Colors.blue.shade100,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMemoScreen(memo: memo),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
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
