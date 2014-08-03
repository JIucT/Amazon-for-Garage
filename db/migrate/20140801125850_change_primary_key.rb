class ChangePrimaryKey < ActiveRecord::Migration
  def up
    execute "ALTER TABLE users DROP CONSTRAINT customers_pkey;"
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
