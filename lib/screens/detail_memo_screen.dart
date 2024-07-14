import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:swagger_golang_flutter_sample/api/lib/api.dart';

class DetailMemoScreen extends StatelessWidget {
  const DetailMemoScreen({
    required this.memo,
    super.key,
  });

  final Memo memo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(memo.title ?? 'No title'),
            const Gap(24),
            const Text(
              'Content',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(memo.content ?? 'No content'),
            const Gap(24),
            const Text(
              'Tags',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
      ),
    );
  }
}
