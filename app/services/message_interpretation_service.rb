class MessageInterpretationService
  def self.call(message)
    sender = message.user
    receiver = message.room.other_participant(sender)
    # 1 Users source language is the other users target language
    res = HTTParty.post(
      "#{ENV['TRANSLATE_URL']}/translate/#{receiver.user.language.downcase}",
      body: {
        sentences: [message.source_text]
      }.to_json,
      headers: {'Content-Type' => 'application/json'}
    ).parsed_response

    res["translations"].first
  end
end
