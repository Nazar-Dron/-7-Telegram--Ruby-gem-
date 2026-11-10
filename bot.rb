require 'telegram/bot'
require 'dotenv'
require 'net/http'
require 'uri'
require 'nokogiri'

Dotenv.load

token = ENV['TELEGRAM_BOT_TOKEN']

unless token
  puts "Помилка: Токен не знайдено у файлі .env"
  exit
end

def fetch_page_title(url_string)
  url_string = "https://#{url_string}" unless url_string.start_with?('http://', 'https://')
  
  uri = URI.parse(url_string)
  
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPRedirection) && response['location']
    redirect_uri = URI.parse(response['location'])
    redirect_uri = uri + redirect_uri if redirect_uri.relative?
    response = Net::HTTP.get_response(redirect_uri)
  end

  unless response.is_a?(Net::HTTPSuccess)
    return "Не вдалося завантажити сторінку (Код відповіді: #{response.code})"
  end

  doc = Nokogiri::HTML(response.body)
  title = doc.at_css('title')&.text&.strip

  if title && !title.empty?
    "📄 **Заголовок сторінки:**\n#{title}"
  else
    "⚠️ Заголовок (<title>) на цій сторінці не знайдено."
  end
rescue URI::InvalidURIError
  "❌ Некоректний URL. Перевірте правильність вводу."
rescue SocketError, Errno::ECONNREFUSED
  "❌ Не вдалося з'єднатися із сервером. Перевірте адресу сайту."
rescue StandardError => e
  "❌ Помилка при виконанні запиту: #{e.message}"
end

Telegram::Bot::Client.run(token) do |bot|
  puts "HTTP Fetcher Bot запущено..."

  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      case message.text
      when '/start'
        bot.api.send_message(
          chat_id: message.chat.id,
          text: "Привіт! Надішли мені URL вебсайту (наприклад, `github.com` або `https://ruby-lang.org`), і я знайду його заголовок!"
        )
      when nil
        next
      else
        bot.api.send_message(chat_id: message.chat.id, text: "🔍 Отримую дані з #{message.text}...")
        
        result = fetch_page_title(message.text)
        
        bot.api.send_message(
          chat_id: message.chat.id,
          text: result,
          parse_mode: 'Markdown'
        )
      end
    end
  end
end
