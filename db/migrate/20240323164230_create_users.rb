# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null; false, index: { unique: true }
      t.string :json_web_token, null; false, # text is better

      t.timestamps
    end
  end
end
