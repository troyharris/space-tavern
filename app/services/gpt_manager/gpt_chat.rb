module GptManager
  class GptChat
    def initialize(system_prompt, user_prompt)
      @system_prompt = system_prompt
      @user_prompt = user_prompt
      @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
    end

    def chat
      response = @client.chat(
        parameters: {
          model: "gpt-4o",
          messages: [{ role: "system", content: @system_prompt }, { role: "user", content: @user_prompt }],
          max_tokens: 1000
        }
      )
      return response.dig("choices", 0, "message", "content")
    end

    def strip_markdown(text)
      # Remove markdown code block markers and any language specifiers
      text = text.gsub(/```(?:json)?\n?/, '')
      # Remove any trailing backticks that might be left
      text = text.gsub(/```$/, '')
      # Trim any whitespace
      text.strip
    end

    def parse_chat(chat)
      # Strip any markdown formatting before parsing
      clean_chat = strip_markdown(chat)
      return JSON.parse(clean_chat)
    end

    def generate_chat_object
      raw_chat = chat
      return parse_chat(raw_chat)
    end
  end
end
