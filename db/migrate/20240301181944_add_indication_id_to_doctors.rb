# frozen_string_literal: true

class AddIndicationIdToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_reference :doctors, :indication, null: false, foreign_key: true
  end
end
