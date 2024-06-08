require "ruby/openai"

module GptManager
  class CreatePatrons
    def self.generate_patrons
      system_prompt = PROMPTS[:global_system_prompt]
      user_prompt = PROMPTS[:generate_patrons]
      chat = GptChat.new(system_prompt, user_prompt)
      return chat.chat
    end
    def self.parse_patrons(patrons)
      return JSON.parse(patrons)
    end
    def self.create_patron_objects(game, patrons)
      patrons.map do |patron|
        Patron.create(
          game: game,
          name: patron["name"],
          description: patron["description"],
          job: patron["job"],
          age: patron["age"],
          credits: patron["credits"]
        )
      end
    end
    def self.create_patrons(game)
      patrons = self.generate_patrons
      parsed_patrons = self.parse_patrons(patrons)
      self.create_patron_objects(game, parsed_patrons)
    end
  end
end

