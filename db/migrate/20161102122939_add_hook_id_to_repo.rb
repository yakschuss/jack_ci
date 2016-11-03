class AddHookIdToRepo < ActiveRecord::Migration[5.0]
  def change
    add_column :repos, :hook_id, :string
  end
end
