Sequel.migration do
  change do

    create_table :o_auth_authentications do
      primary_key :id
      String :provider_uid, null: false
      String :provider_name, null: false
      Time :created_at, null: false, default: Sequel.function(:now)
      Time :updated_at, null: false, default: Sequel.function(:now)
      uuid :user_id
      foreign_key [:user_id], :users
      index [:provider_uid, :provider_name], unique: true
    end

  end
end
