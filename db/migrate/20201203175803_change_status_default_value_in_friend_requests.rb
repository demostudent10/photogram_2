class ChangeStatusDefaultValueInFriendRequests < ActiveRecord::Migration[6.0]
  def change
    change_column_default :friend_requests, :status, 'pending'
  end
end
