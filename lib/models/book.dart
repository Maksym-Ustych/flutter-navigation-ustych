class Book {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String description;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
  });
}

const books = <Book>[
  Book(
    id: '1',
    title: 'Clean Code',
    author: 'Robert C. Martin',
    genre: 'Programming',
    description: 'Практичні принципи написання чистого та зрозумілого коду.',
  ),
  Book(
    id: '2',
    title: 'The Pragmatic Programmer',
    author: 'Andrew Hunt, David Thomas',
    genre: 'Programming',
    description: 'Поради та підходи для професійної розробки програмного забезпечення.',
  ),
  Book(
    id: '3',
    title: 'Design Patterns',
    author: 'Erich Gamma et al.',
    genre: 'Programming',
    description: 'Класичні шаблони проєктування програмного забезпечення.',
  ),
  Book(
    id: '4',
    title: 'Flutter in Action',
    author: 'Eric Windmill',
    genre: 'Flutter',
    description: 'Практичний вступ до розробки застосунків на Flutter.',
  ),
  Book(
    id: '5',
    title: 'Dart Apprentice',
    author: 'Ray Wenderlich Team',
    genre: 'Flutter',
    description: 'Основи мови Dart для розробки Flutter-застосунків.',
  ),
  Book(
    id: '6',
    title: 'Refactoring',
    author: 'Martin Fowler',
    genre: 'Programming',
    description: 'Методи покращення структури існуючого коду.',
  ),
  Book(
    id: '7',
    title: 'Computer Networks',
    author: 'Andrew S. Tanenbaum',
    genre: 'Networks',
    description: 'Основи комп’ютерних мереж і мережних протоколів.',
  ),
  Book(
    id: '8',
    title: 'Network Security Essentials',
    author: 'William Stallings',
    genre: 'Security',
    description: 'Основи захисту інформації та мережної безпеки.',
  ),
  Book(
    id: '9',
    title: 'Operating System Concepts',
    author: 'Abraham Silberschatz',
    genre: 'Systems',
    description: 'Архітектура та принципи роботи операційних систем.',
  ),
  Book(
    id: '10',
    title: 'Database System Concepts',
    author: 'Abraham Silberschatz',
    genre: 'Databases',
    description: 'Основи баз даних, SQL та проєктування БД.',
  ),
  Book(
    id: '11',
    title: 'Python Crash Course',
    author: 'Eric Matthes',
    genre: 'Programming',
    description: 'Практичний курс програмування мовою Python.',
  ),
  Book(
    id: '12',
    title: 'Java: The Complete Reference',
    author: 'Herbert Schildt',
    genre: 'Programming',
    description: 'Повний довідник із мови Java.',
  ),
  Book(
    id: '13',
    title: 'Introduction to Algorithms',
    author: 'Thomas H. Cormen et al.',
    genre: 'Algorithms',
    description: 'Алгоритми, структури даних та аналіз складності.',
  ),
  Book(
    id: '14',
    title: 'Software Engineering',
    author: 'Ian Sommerville',
    genre: 'Engineering',
    description: 'Основи процесів та методів програмної інженерії.',
  ),
  Book(
    id: '15',
    title: 'Artificial Intelligence',
    author: 'Stuart Russell, Peter Norvig',
    genre: 'AI',
    description: 'Основні концепції та методи штучного інтелекту.',
  ),
];

Book? findBookById(String id) {
  for (final book in books) {
    if (book.id == id) {
      return book;
    }
  }
  return null;
}