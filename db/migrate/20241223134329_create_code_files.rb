class CreateCodeFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :code_files do |t|
      t.text :content
      t.string :url

      t.string :path, index: true
      t.decimal :overall_grade
      t.text :overall_review
      t.decimal :security_grade
      t.text :security_review
      t.decimal :refactoring_grade
      t.text :refactoring_review
      t.decimal :performance_grade
      t.text :performance_review
      t.references :repository, null: false, foreign_key: true

      t.datetime :sync_at

      t.timestamps
    end
  end
end
