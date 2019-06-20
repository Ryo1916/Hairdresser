class DropPunches < ActiveRecord::Migration[5.1]
  def change
    drop_table :punches
  end
end
