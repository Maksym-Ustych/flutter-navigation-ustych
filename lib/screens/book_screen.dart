import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';

class BookScreen extends StatelessWidget {
  final String bookId;

  const BookScreen({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    final book = findBookById(bookId);

    if (book == null) {
      return const Scaffold(
        body: Center(
          child: Text('Книгу не знайдено'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              book.author,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(book.genre),
            ),
            const SizedBox(height: 20),
            Text(
              book.description,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  context.push(
                    '/catalog/book/${book.id}/reserve',
                  );
                },
                icon: const Icon(Icons.bookmark_add),
                label: const Text('Забронювати'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}