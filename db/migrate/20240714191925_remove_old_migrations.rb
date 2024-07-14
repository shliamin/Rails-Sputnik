class RemoveOldMigrations < ActiveRecord::Migration[5.2]
  def up
    migrations_to_remove = [
      "20190528090052",
      "20190528093857",
      "20190528094418",
      "20190528094538",
      "20190528153447",
      "20190528154219",
      "20190528154517",
      "20190529101553",
      "20190529131120",
      "20190529131139",
      "20190529131226",
      "20190529142103",
      "20190529143051",
      "20190530100301",
      "20190603101933",
      "20190604155225"
    ]

    migrations_to_remove.each do |migration|
      execute "DELETE FROM schema_migrations WHERE version = '#{migration}'"
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
