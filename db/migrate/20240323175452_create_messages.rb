# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :title, null: false
      t.string :body # text is better
      t.references :user

      t.timestamps
    end
  end
end
