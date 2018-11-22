class CreateJoinTableCasting < ActiveRecord::Migration[5.2]
  def change
    create_join_table :people, :movies, table_name: :casting do |t|
      t.index [:person_id, :movie_id], unique: true
      t.index [:movie_id, :person_id]
    end
  end
end
