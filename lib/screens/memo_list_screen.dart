import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swagger_golang_flutter_sample/screens/create_memo_screen.dart';
import 'package:swagger_golang_flutter_sample/screens/detail_memo_screen.dart';
import 'package:swagger_golang_flutter_sample/screens/edit_memo_screen.dart';
import 'package:swagger_golang_flutter_sample/screens/state/memo_controller.dart';

class MemoListScreen extends HookConsumerWidget {
  const MemoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoController = ref.watch(memoControllerProvider.notifier);
    final memos = ref.watch(memoControllerProvider);
    final searchController = useTextEditingController();
    final searchDebounce = useState<Timer?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        memoController.fetchMemos();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memos'),
      ),
      body: memos.when(
        data: (memoList) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search Memos',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      searchController.clear();
                      memoController.fetchMemos();
                    },
                  ),
                ),
                onChanged: (value) {
                  searchDebounce.value?.cancel();
                  searchDebounce.value = Timer(
                    const Duration(milliseconds: 500),
                    () {
                      memoController.searchMemos(value);
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: memoList.length,
                itemBuilder: (context, index) {
                  final memo = memoList[index];
                  return Dismissible(
                    key: Key(memo.id.toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      ref
                          .read(memoControllerProvider.notifier)
                          .deleteMemo(memo.id!);
                    },
                    child: ListTile(
                      title: Text(memo.title ?? ''),
                      subtitle: Text(memo.content ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditMemoScreen(memo: memo),
                            ),
                          );
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateMemoScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
