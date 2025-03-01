class MessageInterpretationService
  def call(message)
    sender = message.user
    receiver = message.room.other_participant(sender)
    deepl_translate(message.source_text, receiver.user.language.downcase)
  rescue DeepL::Exceptions::DocumentTranslationError, DeepL::Exceptions::LimitExceeded,
         DeepL::Exceptions::QuotaExceeded,
         DeepL::Exceptions::RequestError
    google_translate(message.source_text, receiver.user.language.downcase)
  end

  private

  def deepl_translate(text, target_lang)
    translation = DeepL.translate text, nil, target_lang, model_type: 'prefer_quality_optimized'
    translation.text
  end

  def google_translate(text, target_lang)
    encoded_text = URI.encode_www_form_component(text)
    url = "https://translation.googleapis.com/language/translate/v2?key=#{ENV['GOOGLE_TRANSLATE_API_KEY']}&q=#{encoded_text}&target=#{target_lang}"

    res = HTTParty.get(url).parsed_response
    translation = res.dig("data", "translations", 0, "translatedText")

    if translation
      puts "✅ Google Translate used: #{translation}"
    else
      puts "❌ Google Translate also failed!"
    end
    translation
  end
end
