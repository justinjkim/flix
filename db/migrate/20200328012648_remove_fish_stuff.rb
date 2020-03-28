class RemoveFishStuff < ActiveRecord::Migration[6.0]
  def up
    drop_table :fish
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
