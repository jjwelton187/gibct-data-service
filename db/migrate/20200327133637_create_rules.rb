class CreateRules < ActiveRecord::Migration[5.2]
  def up
    create_table :rules do |t|
      t.string :rule_name, null: false
      t.string :matcher, null: false
      t.string :subject
      t.string :predicate
      t.string :object
      t.integer :priority

      t.timestamps
    end
  end

  def down
    drop_table :rules
  end
end
