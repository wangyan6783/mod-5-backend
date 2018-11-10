class AddChatRoomIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :chat_room_id, :string
  end
end
