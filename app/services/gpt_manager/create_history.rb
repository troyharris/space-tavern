module GptManager
    class CreateHistory
        def initialize(game)
            @game = game
        end

        def create_history
            system_prompt = "You are an AI assistant tasked with summarizing the events of a game into a cohesive narrative. Please provide a summary that encapsulates the essence and key moments of the game. Return a plaintext string of one or two paragraphs."
            events = @game.events
            event_descriptions = events.map(&:description).join(", ")
            user_prompt = "Summarize the following events into a cohesive, efficient, and concise narrative. Your guiding principles include a preference for strong verbs over adverbs and adjectives and a strict adherence to the Strunk and White grammar rules: #{event_descriptions}"
            
            gpt_chat = GptChat.new(system_prompt, user_prompt)
            return gpt_chat.chat
        end
    end
end
