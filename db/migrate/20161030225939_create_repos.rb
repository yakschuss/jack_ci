class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.string :full_name, null: false
      t.string :name, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
