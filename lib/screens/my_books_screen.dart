import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/book.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key});

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day.$month.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мої книги'),
      ),
      body: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          final reservations = appState.reservations;

          if (reservations.isEmpty) {
            return const Center(
              child: Text(
                'Заброньованих книг поки немає',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              final book = findBookById(reservation.bookId);

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.bookmark),
                  title: Text(
                    book?.title ?? 'Невідома книга',
                  ),
                  subtitle: Text(
                    'Повернути до: '
                    '${_formatDate(reservation.returnDate)}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}