# frozen_string_literal: true

class CreateIndications < ActiveRecord::Migration[6.0]
  def change
    create_table :indications do |t|
      t.string :name

      t.timestamps
    end
  end
end
