class RenameTypeColumnInMessages < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :type, :message_type
  end
end
