module GptManager
    class CreateEvent
        def initialize(game)
            @game = game
        end

        def create_event(event_type)
            system_prompt = PROMPTS['event_system_prompt']
            base_user_prompt = PROMPTS['event_user_prompts'][event_type]
            patrons = @game.patrons.select { |patron| patron.is_visiting }
            patron_info = patrons.map do |patron|
                "Name: #{patron.name}\nAge: #{patron.age}\nJob: #{patron.job}\nDescription: #{patron.description}"
            end.join("\n")
            user_prompt = base_user_prompt + "\nCurrently in the tavern:\n" + patron_info
            user_prompt += "\nGiven the tavern's history: "
            user_prompt += @game.history ? "\"#{@game.history}\"," : "\"No significant events have occurred yet.\","
            puts "User prompt: #{user_prompt}"
            return GptChat.new(system_prompt, user_prompt).chat
        end
    end
end

