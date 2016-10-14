class CreateMessage < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.string :uid,           :limit => 255
      t.string :link,          :limit => 255
      #
      t.text   :message,       :limit => 65535
      #t.string :message
      t.string :key,           :limit => 255
      t.string :iv,            :limit => 255
      #
      t.integer :visit_count,  :limit => 4, default: 0
      t.integer :visit_total,  :limit => 4, default: 0
      t.datetime :expires_at

      t.timestamps
    end
  end

  def down
    drop_table :messages
  end
end
