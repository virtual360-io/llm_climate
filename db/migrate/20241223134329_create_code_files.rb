class CreateCodeFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :code_files do |t|
      t.string :path
      t.integer :overrall_grade
      t.text :overral_review
      t.integer :security_grade
      t.text :security_review
      t.integer :refactoring_grade
      t.text :refactoring_review
      t.integer :performance_grade
      t.text :performance_review
      t.references :repository, null: false, foreign_key: true

      t.datetime :sync_at

      t.timestamps
    end
  end
end
