class RenameColumnComments < ActiveRecord::Migration[7.0]
  def change
    rename_column(:comments, :confidence, :rate)
  end
end
