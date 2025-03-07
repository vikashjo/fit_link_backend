require 'faraday'
require 'json'

class DeepSeekAPI
    BASE_URL = "https://api.deepseek.com/v1/chat/completions"

    def self.get_macros(food_name)
        response = Faraday.post(BASE_URL) do |req|
            req.headers['Content-Type'] = 'application/json'
            req.headers['Authorization'] = "Bearer #{ENV['DEEPSEEK_API_KEY']} "
            req.body = {
                model: "deepseek-chat",
                messages: [
                    { role: "system", content: "You are a nutrition assistant. Return only JSON format." },
                    { role: "user", content: "Give macros for #{food_name} in strict JSON format with keys: calories, protein, carbs, fats. If not found, return {\"error\": \"No data found\"}." }
                ]
            }.to_json
        end

        if response.success?
            begin
              json_response = JSON.parse(response.body)
              content = json_response.dig("choices", 0, "message", "content")
        
              # Ensure response is JSON
             parsed_macros = JSON.parse(content) rescue nil

             return parsed_macros.is_a?(Hash) ? parsed_macros : { error: "Invalid format from API" }
            rescue JSON::ParserError
              { error: "Invalid API response format" }
            end
        else  
            { error: JSON.parse(response.body).dig("error", "message") , status: response.status }
        end
    end
end