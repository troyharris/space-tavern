module MessageManager
  class MessageService
    def self.create_message(game, message_type, message_content)
      Message.create!(
        day: game.day,
        time: game.current_time.strftime("%H:%M"),
        message_type: message_type,
        message: message_content,
        game_id: game.id
      )
    end
  end
end
