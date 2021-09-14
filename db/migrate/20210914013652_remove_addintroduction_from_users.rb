class RemoveAddintroductionFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :Addintroduction, :text
  end
end
