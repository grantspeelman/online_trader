Sequel.migration do
  change do

    create_table :users do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      String :name, null: false, default: ''
      Time :created_at, null: false
      Time :updated_at, null: false
    end

  end
end
