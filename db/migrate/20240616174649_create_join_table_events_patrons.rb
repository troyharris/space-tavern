class CreateJoinTableEventsPatrons < ActiveRecord::Migration[7.1]
  def change
    create_join_table :events, :patrons do |t|
      # t.index [:event_id, :patron_id]
      # t.index [:patron_id, :event_id]
    end
  end
end
