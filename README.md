Практична робота 7 — Роутинг і навігація у Flutter

Студент: Устич Максим
Група: alk-43
Спеціальність: 121 Інженерія програмного забезпечення
Варіант: 1 — Бібліотека коледжу

Опис проєкту

Flutter-застосунок для перегляду каталогу та бронювання книг бібліотеки коледжу.

Навігація реалізована за допомогою go_router 17.x.

У застосунку реалізовано:

каталог із 15 книгами;

фільтрацію книг за жанром;

три вкладки: «Каталог», «Мої книги», «Профіль»;

збереження стану вкладок через StatefulShellRoute.indexedStack;

параметри шляху та параметри запиту;

захищений маршрут бронювання;

автоматичне повернення після входу;

вибір дати повернення книги;

повернення результату через push/pop;

PopScope для незбережених змін;

errorBuilder для невідомих маршрутів;

deep link для Android та iOS.

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

Для основної навігації використано StatefulShellRoute.indexedStack.

Вкладки:

Каталог

Мої книги

Профіль

Кожна вкладка має власний навігаційний стек. Стан вкладки зберігається при перемиканні.

Guard та redirect

Маршрут бронювання:

/catalog/book/:bookId/reserve

доступний лише користувачу, який увійшов.

Якщо гість намагається відкрити бронювання, застосунок перенаправляє його на:

/login?from=...

Після успішного входу користувач автоматично повертається до сторінки бронювання.

Для оновлення маршрутизації використано refreshListenable.

Повернення результату

Екран вибору дати відкривається через:

context.push<DateTime>('/return-date');

Обрана дата повертається через:

context.pop(selectedDate);

Після повернення дата відображається на екрані бронювання.

PopScope

На екрані бронювання використано PopScope.

Якщо користувач вибрав дату повернення, але ще не підтвердив бронювання, при спробі вийти з екрана з'являється діалог підтвердження.

Deep link

Для застосунку використовується власна схема:

library://app/catalog/book/<id>

Приклад:

library://app/catalog/book/1

Ця адреса відкриває сторінку книги Clean Code.

Перевірка на Android

& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "library://app/catalog/book/1"

Перевірка на iOS Simulator

xcrun simctl openurl booted "library://app/catalog/book/1"

Deep link налаштовано у файлах:

android/app/src/main/AndroidManifest.xml

ios/Runner/Info.plist

Перевірка deep link фактично виконувалась на Android-емуляторі.

Обробка помилок

Для невідомої адреси використано errorBuilder.

Користувач бачить повідомлення про те, що сторінку не знайдено, та кнопку повернення до каталогу.

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

Запуск проєкту

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

Скріншоти

Збереження стану вкладки

Відкрита книга залишається на місці після переходу у вкладку «Профіль» і повернення до «Каталогу».



Повернення після входу

При спробі бронювання без входу користувач переходить на сторінку входу. Після входу застосунок автоматично повертає його до бронювання.



Deep link

Deep link library://app/catalog/book/1 відкриває книгу Clean Code.



Труднощі та їх розв'язання

Повернення після авторизації

Спочатку після натискання кнопки входу користувач не повертався до захищеного маршруту.

Проблему вирішено передаванням початкової адреси через query-параметр from. Після входу виконується перехід на збережену адресу.

ADB у Windows

Команда adb не розпізнавалась у PowerShell, оскільки Android Platform Tools не були додані до PATH.

Для перевірки deep link використано повний шлях до adb.exe.

Deep link

Для підтримки власної схеми library:// окремо налаштовано Android та iOS.

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

Deep Linking

Git