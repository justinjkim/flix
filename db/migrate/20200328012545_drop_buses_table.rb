class DropBusesTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :buses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
