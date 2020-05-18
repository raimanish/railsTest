class AddOrganizationIdToTweet < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :organization_id, :integer
    add_column :users, :organization_id, :integer
  end
end
