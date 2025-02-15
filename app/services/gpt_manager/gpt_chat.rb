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

      def parse_chat(chat)
        return JSON.parse(chat)
      end

      def generate_chat_object
        raw_chat = chat
        return parse_chat(raw_chat)
      end
    end
end