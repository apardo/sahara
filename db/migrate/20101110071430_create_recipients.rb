class CreateRecipients < ActiveRecord::Migration
  def self.up
    create_table :recipients do |t|
      t.string :email
      t.string :lang

      t.timestamps
    end
  end

  def self.down
    drop_table :recipients
  end
end
