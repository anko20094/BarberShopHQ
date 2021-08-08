class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.text :name
      t.integer :phone
      t.text :question

      t.timestamps
    end
  end
end
