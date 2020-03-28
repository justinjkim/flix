class DropBasketballsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :basketballs
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
