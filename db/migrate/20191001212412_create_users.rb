class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :nickname
      t.string :email
      t.string :name
      t.string :avatar
      t.string :provider_token
      t.string :provider_refresh_token

      t.timestamps
    end
  end
end
