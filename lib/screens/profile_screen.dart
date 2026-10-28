import 'package:flutter/material.dart';

import '../app_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _cardController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: appState.name,
    );

    _cardController = TextEditingController(
      text: appState.cardNumber,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  void _save() {
    appState.updateProfile(
      name: _nameController.text.trim(),
      cardNumber: _cardController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Профіль збережено'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профіль'),
      ),
      body: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ім’я',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _cardController,
                decoration: const InputDecoration(
                  labelText: 'Номер читацького квитка',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _save,
                child: const Text('Зберегти профіль'),
              ),
              const SizedBox(height: 24),
              Text(
                appState.loggedIn
                    ? 'Статус: користувач увійшов'
                    : 'Статус: гість',
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: appState.loggedIn
                    ? appState.logout
                    : appState.login,
                icon: Icon(
                  appState.loggedIn
                      ? Icons.logout
                      : Icons.login,
                ),
                label: Text(
                  appState.loggedIn
                      ? 'Вийти'
                      : 'Увійти',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}