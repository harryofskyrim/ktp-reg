class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :eventTitle
      t.string :eventType
      t.integer :teamMinSize
      t.integer :teamMaxSize
      t.date :dateStart
      t.date :dateEnd
      t.string :eventPlace
      t.text :eventDescription
      t.text :eventResults

      t.timestamps
    end
  end
end
