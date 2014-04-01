class CreateFormFieldsHousingFormsJoinTable < ActiveRecord::Migration
  def change
    create_table :form_fields_housing_forms, id: false do |t|
      t.integer :form_field_id
      t.integer :housing_form_id
    end
  end
end
