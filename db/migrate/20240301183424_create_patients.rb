# frozen_string_literal: true

class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :doctor, foreign_key: true
      t.references :indication, null: false, foreign_key: true

      t.timestamps
    end
  end
end
