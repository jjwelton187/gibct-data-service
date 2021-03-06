class AddSchoolClosuresToInstitutions < ActiveRecord::Migration[4.2]
  def change
    add_column :institutions, :school_closing, :boolean
    add_column :institutions, :school_closing_on, :date
    add_column :institutions, :school_closing_message, :string
  end
end
