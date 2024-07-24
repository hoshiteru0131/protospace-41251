class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :params_id
      t.text :text, null: false
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.references :prototype, null: false, foreign_key: true

    end
  end
end
