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
            model: "gpt-3.5-turbo",
            messages: [{ role: "system", content: @system_prompt }, { role: "user", content: @user_prompt }],
            max_tokens: 1000
          }
        )
        return response.dig("choices", 0, "message", "content")
      end
    end
end