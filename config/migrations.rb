
p "Migrations"

migration 'create packages' do
  database.create_table :packages do
    primary_key :id
    String :name, :unique => true, :null => false
    String :url, :unique => true, :null => false
    DateTime :created_at
    index :name
  end
end

migration 'add hits' do
  database.alter_table :packages do
    add_column :hits, Integer, :default => 0
  end
end
