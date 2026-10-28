import 'package:flutter/foundation.dart';

class Reservation {
  final String bookId;
  final DateTime returnDate;

  const Reservation({
    required this.bookId,
    required this.returnDate,
  });
}

class AppState extends ChangeNotifier {
  bool _loggedIn = false;

  String _name = '';
  String _cardNumber = '';

  final List<Reservation> _reservations = [];

  bool get loggedIn => _loggedIn;
  String get name => _name;
  String get cardNumber => _cardNumber;

  List<Reservation> get reservations =>
      List.unmodifiable(_reservations);

  void login() {
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }

  void updateProfile({
    required String name,
    required String cardNumber,
  }) {
    _name = name;
    _cardNumber = cardNumber;
    notifyListeners();
  }

  void reserveBook({
    required String bookId,
    required DateTime returnDate,
  }) {
    _reservations.removeWhere(
      (reservation) => reservation.bookId == bookId,
    );

    _reservations.add(
      Reservation(
        bookId: bookId,
        returnDate: returnDate,
      ),
    );

    notifyListeners();
  }
}

final appState = AppState();