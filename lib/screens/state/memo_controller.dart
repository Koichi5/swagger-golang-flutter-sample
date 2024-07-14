import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swagger_golang_flutter_sample/api/lib/api.dart';

part 'memo_controller.g.dart';

@riverpod
class MemoController extends _$MemoController {
  final DefaultApi _api = DefaultApi(ApiClient());

  @override
  Future<List<Memo>> build() async {
    return [];
  }

  Future<void> fetchMemos() async {
    state = const AsyncValue.loading();
    try {
      final memos = await _api.memosGet() ?? [];
      state = AsyncValue.data(memos);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createMemo(NewMemo newMemo) async {
    final createdMemo = await _api.memosPost(newMemo);
    if (createdMemo != null) {
      state = AsyncValue.data([...state.value ?? [], createdMemo]);
    }
  }

  Future<void> updateMemo(int id, NewMemo updatedMemo) async {
    state = const AsyncValue.loading();
    try {
      final updated = await _api.memosMemoIdPut(id, updatedMemo);
      if (updated != null) {
        state = AsyncValue.data(state.value!.map((memo) {
          return memo.id == id ? updated : memo;
        }).toList());
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteMemo(int id) async {
    try {
      await _api.memosMemoIdDelete(id.toString());
      state = AsyncValue.data(
        state.value?.where((memo) => memo.id != id).toList() ?? []
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> searchMemos(String keyword) async {
    state = const AsyncValue.loading();
    try {
      final searchedMemos = await _api.memosSearchGet(keyword) ?? [];
      state = AsyncValue.data(searchedMemos);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
