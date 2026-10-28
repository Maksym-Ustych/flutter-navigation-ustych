import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';

class CatalogScreen extends StatelessWidget {
  final String? genre;

  const CatalogScreen({
    super.key,
    this.genre,
  });

  @override
  Widget build(BuildContext context) {
    final genres = <String>{
      'Усі',
      ...books.map((book) => book.genre),
    }.toList();

    final filteredBooks = genre == null || genre == 'Усі'
        ? books
        : books.where((book) => book.genre == genre).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                final item = genres[index];

                final selected =
                    (genre == null && item == 'Усі') || genre == item;

                return ChoiceChip(
                  label: Text(item),
                  selected: selected,
                  onSelected: (_) {
                    if (item == 'Усі') {
                      context.go('/catalog');
                    } else {
                      context.go(
                        '/catalog?genre=${Uri.encodeComponent(item)}',
                      );
                    }
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.menu_book),
                    title: Text(book.title),
                    subtitle: Text(
                      '${book.author}\n${book.genre}',
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.go(
                        '/catalog/book/${book.id}',
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}