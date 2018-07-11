class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :lastName
      t.string :firstName
      t.string :fathersName
      t.date :born
      t.string :email
      t.string :phoneNumber
      t.string :teeSize
      t.string :occupation
      t.string :school
      t.string :group
      t.string :password_digest

      t.timestamps
    end
  end
end
