class CreateUserAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :user_access_tokens do |t|
      t.text :access_token
      t.boolean :active, null: true, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
