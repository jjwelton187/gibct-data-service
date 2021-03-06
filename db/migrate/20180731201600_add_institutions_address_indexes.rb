class AddInstitutionsAddressIndexes < ActiveRecord::Migration[4.2]
  disable_ddl_transaction!

  def change
    add_index(:institutions, :address_1, algorithm: :concurrently)
    add_index(:institutions, :address_2, algorithm: :concurrently)
    add_index(:institutions, :address_3, algorithm: :concurrently)
  end
end
