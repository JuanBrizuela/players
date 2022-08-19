class CreatePlayersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :external_id
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.integer :age
      t.string :elias_id
      t.string :photo_url
      t.integer :eligible_for_offense_and_defense
      t.string :throws
      t.string :pro_status
      t.string :pro_team
      t.string :bats
      t.string :jersey
      t.string :position
      t.string :icons

      t.timestamps
    end
  end
end
