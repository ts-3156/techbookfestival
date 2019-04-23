ActiveRecord::Migration.create_table :users do |t|
  t.bigint :uid
  t.string :screen_name
  t.string :name
  t.text :description
  t.text :tweet

  t.index :uid, unique: true
  t.index :screen_name
end
