Практична робота 7 — Роутинг і навігація у Flutter

Студент: Устич Максим
Група: alk-43
Спеціальність: 121 Інженерія програмного забезпечення
Варіант: 1 — Бібліотека коледжу

Опис

Flutter-застосунок для перегляду каталогу та бронювання книг бібліотеки коледжу.

Навігація реалізована за допомогою пакета go_router 17.x.

У застосунку реалізовано:

каталог із 15 книгами;

фільтрацію книг за жанром;

екран інформації про книгу;

три вкладки: «Каталог», «Мої книги», «Профіль»;

збереження стану вкладок через StatefulShellRoute.indexedStack;

параметри шляху та параметри запиту;

захищений маршрут бронювання;

автоматичне повернення після входу;

вибір дати повернення з поверненням результату;

PopScope для форми з незбереженими змінами;

errorBuilder для невідомих маршрутів;

deep link library://app/catalog/book/<id>;

підтримку deep link для Android та iOS.

Карта маршрутів

Маршрут

Екран

Захист

/catalog

CatalogScreen

—

/catalog?genre=...

CatalogScreen

—

/catalog/book/:bookId

BookScreen

—

/catalog/book/:bookId/reserve

ReserveScreen

Потрібен вхід

/my-books

MyBooksScreen

—

/profile

ProfileScreen

—

/login?from=...

LoginScreen

—

/return-date

DatePickerScreen

—

Нижня навігація

Для трьох основних вкладок використано:

StatefulShellRoute.indexedStack

Вкладки:

Каталог

Мої книги

Профіль

Кожна вкладка має власний навігаційний стек. При переході між вкладками відкритий екран не втрачається.

Guard та redirect

Маршрут:

/catalog/book/:bookId/reserve

доступний лише після входу.

Якщо гість натискає «Забронювати», застосунок перенаправляє його на:

/login?from=...

Після входу користувач автоматично повертається на сторінку бронювання, яку намагався відкрити.

Для оновлення маршрутизації використовується refreshListenable.

Повернення результату

Екран вибору дати відкривається через:

context.push<DateTime>('/return-date')

Обрана дата повертається через:

context.pop(selectedDate)

Після цього дата відображається на екрані бронювання.

PopScope

На екрані бронювання використано PopScope.

Якщо користувач вибрав дату, але ще не підтвердив бронювання, при спробі вийти з екрана з'являється діалог підтвердження.

Deep link

Для варіанта 1 використовується власна схема:

library://app/catalog/book/<id>

Приклад:

library://app/catalog/book/1

відкриває книгу Clean Code.

Перевірка на Android

& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "library://app/catalog/book/1"

Перевірка на iOS Simulator

На macOS можна використати:

xcrun simctl openurl booted "library://app/catalog/book/1"

Схему library налаштовано в:

android/app/src/main/AndroidManifest.xml

ios/Runner/Info.plist

Перевірка deep link фактично виконувалася на Android-емуляторі.

Error handling

Для невідомої адреси використано errorBuilder.

Користувач бачить повідомлення «Сторінку не знайдено» та кнопку повернення до каталогу.

Структура проєкту

lib/
├── models/
│   └── book.dart
├── screens/
│   ├── book_screen.dart
│   ├── catalog_screen.dart
│   ├── date_picker_screen.dart
│   ├── error_screen.dart
│   ├── login_screen.dart
│   ├── my_books_screen.dart
│   ├── profile_screen.dart
│   ├── reserve_screen.dart
│   └── shell_screen.dart
├── app_state.dart
├── router.dart
└── main.dart

Запуск

Завантажити залежності:

flutter pub get

Перевірити код:

flutter analyze

Запустити тести:

flutter test

Запустити у Chrome:

flutter run -d chrome

Запустити на Android-емуляторі:

flutter run -d emulator-5554

Демонстрація

Збереження стану вкладки

Відкрита книга залишається на місці після переходу в «Профіль» і повернення до «Каталогу».



Guard і повернення після входу

Спроба бронювання без входу переводить на сторінку входу. Після входу користувач автоматично повертається до бронювання.



Deep link

Deep link відкриває сторінку книги Clean Code.



Труднощі та їх розв'язання

Повернення після авторизації

Спочатку після натискання кнопки входу користувач не повертався до захищеного маршруту.

Проблему вирішено передаванням початкової адреси через query-параметр from. Після успішного входу виконується перехід на збережену адресу.

Виклик ADB у Windows

Команда adb не розпізнавалася в PowerShell, оскільки каталог Android Platform Tools не був доданий до PATH.

Для перевірки deep link використано повний шлях:

& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe"

Deep link

Для відкриття власної схеми library:// було окремо налаштовано Android та iOS.

Використані технології

Flutter

Dart

go_router 17.x

GoRouter

StatefulShellRoute

StatefulShellBranch

redirect

refreshListenable

ChangeNotifier

PopScope

deep linking

Git