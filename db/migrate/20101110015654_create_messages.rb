class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :body
      t.string :remote_ip
      t.boolean :sent, :default => false
      t.string :lang
      t.string :activation_code, :limit => 40
      t.boolean :active, :default => false
      t.boolean :friend, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
