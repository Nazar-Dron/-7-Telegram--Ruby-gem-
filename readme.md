legseight_bot 

legseight_bot — це Telegram-бот на мові Ruby, створений для отримання заголовків вебсторінок (`<title>`) за наданим URL-посиланням. 

Бот використовує вбудовану бібліотеку `Net::HTTP` для виконання HTTP GET-запитів (з підтримкою редиректів) та гем `nokogiri` для парсингу HTML-структури сторінок.

 Функціонал

Парсинг Web-заголовків:** Приймає будь-яке посилання та повертає текстовий заголовок тегу `<title>` вебсайту.
Підтримка HTTP Редиректів:** Автоматично слідує за перенаправленнями (HTTP 301 / 302).
Захист від помилок:** Безпечно обробляє неіснуючі домени, некоректні URL та обриви мережі завдяки блоку `rescue`.
Безпечна конфігурація:** Токени та ключі доступу зберігаються у змінних середовища `.env`.



Використані технології та геми

[Ruby](https://www.ruby-lang.org/)** (v3.x / 4.x) — основна мова розробки.
[telegram-bot-ruby](https://github.com/atipik/telegram-bot-ruby)** — бібліотека для обробки Telegram Bot API.
[nokogiri](https://nokogiri.org/)** — швидкий HTML/XML парсер.
[dotenv](https://github.com/bkeepers/dotenv)** — менеджер змінних середовища з файлу `.env`.
Net::HTTP & URI** — стандартні бібліотеки Ruby для роботи з HTTP-запитами.



Встановлення та запуск

1. Клонування репозиторію
```bash
git clone https://github.com/Nazar-Dron/-7-Telegram--Ruby-gem-.git
cd -7-Telegram--Ruby-gem-
```

2. Встановлення залежностей
```bash
bundle install
```

3. Налаштування змінних середовища
Створіть файл `.env` у корені проєкту та вкажіть ваш Telegram Bot Token:
```env
TELEGRAM_BOT_TOKEN=ваш_токен_від_botfather
```

4. Запуск бота
```bash
bundle exec ruby bot.rb
```



Приклад використання

1. Надішліть боту команду `/start`.
2. Надішліть URL-адресу сайту, наприклад: `github.com` або `https://ruby-lang.org`.
3. Отримайте результат:
   >  Отримую дані з github.com...  
   >  **Заголовок сторінки:**  
   > GitHub: Let’s build from here · GitHub