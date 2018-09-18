Sequel.migration do
  change do

    create_table :wants do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      String :name, null: false, default: ''
      Integer :amount, null: false, default: 1
      Time :created_at, null: false
      Time :updated_at, null: false
      uuid :user_id
      foreign_key [:user_id], :users
    end

  end
end
