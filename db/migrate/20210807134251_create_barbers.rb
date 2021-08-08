class CreateBarbers < ActiveRecord::Migration[6.1]
  def change
    create_table :barbers do |t|
      t.text :name

      t.timestamps
    end 
    Barber.create :name => 'Jessie Pinkman'
    Barber.create :name => 'Walter White'
    Barber.create :name => 'Gus Fring'

    # Alternative variant to create record in DB
    # b = Barber.new :name=>'Danyil'
    # b.save

  end
end
