require 'openai'

class AiFoodRecognitionService
  def self.get_macros(food_name)

    # client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key))
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

    prompt = "Provide estimated nutritional values for 100g of #{food_name}. Format response as JSON: {calories: X, protein: Y, carbs: Z, fats: W}"

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        max_tokens: 100
      }
    )

    begin
      result = response.dig("choices", 0, "message", "content")
      JSON.parse(result) if result.present?
    rescue JSON::ParserError => e
      Rails.logger.error "AI JSON Parse Error: #{e.message}"
      nil
    end
  rescue StandardError => e
    Rails.logger.error "AI API Error: #{e.message}"
    nil
  end
end
