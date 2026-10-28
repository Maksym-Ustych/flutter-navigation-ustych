import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';
import '../models/book.dart';

class ReserveScreen extends StatefulWidget {
  final String bookId;

  const ReserveScreen({
    super.key,
    required this.bookId,
  });

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  DateTime? _returnDate;
  bool _hasUnsavedChanges = false;

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day.$month.${date.year}';
  }

  Future<void> _selectDate() async {
    final result = await context.push<DateTime>(
      '/return-date',
    );

    if (!mounted) {
      return;
    }

    if (result != null) {
      setState(() {
        _returnDate = result;
        _hasUnsavedChanges = true;
      });
    }
  }

  void _reserve() {
    if (_returnDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Спочатку оберіть дату повернення',
          ),
        ),
      );
      return;
    }

    appState.reserveBook(
      bookId: widget.bookId,
      returnDate: _returnDate!,
    );

    setState(() {
      _hasUnsavedChanges = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Книгу успішно заброньовано',
        ),
      ),
    );

    context.pop();
  }

  Future<bool> _confirmExit() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Незбережені зміни'),
          content: const Text(
            'Дата повернення ще не збережена. Вийти?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Залишитися'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Вийти'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  Future<void> _handlePop() async {
    final shouldExit = await _confirmExit();

    if (!mounted) {
      return;
    }

    if (shouldExit) {
      setState(() {
        _hasUnsavedChanges = false;
      });

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = findBookById(widget.bookId);

    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop || !_hasUnsavedChanges) {
          return;
        }

        _handlePop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Бронювання'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book?.title ?? 'Книга',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              const Text(
                'Дата повернення:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.calendar_month,
                ),
                title: Text(
                  _returnDate == null
                      ? 'Не обрано'
                      : _formatDate(_returnDate!),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: _selectDate,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _reserve,
                  icon: const Icon(Icons.check),
                  label: const Text(
                    'Підтвердити бронювання',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}