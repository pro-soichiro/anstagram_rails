# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.string :email
      t.date :joined_on
      t.date :born_on
      t.string :nickname
      t.string :special_skill
      t.string :pastime
      t.string :motto
      t.text :motto_description
      t.text :career
      t.text :self_introduction

      t.timestamps
    end
  end
end
