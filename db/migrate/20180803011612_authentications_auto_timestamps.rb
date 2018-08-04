Sequel.migration do
  up do
    extension :pg_triggers

    pgt_created_at(:o_auth_authentications, :created_at,
                   function_name: :o_auth_authentications_set_created_at,
                   trigger_name: :set_created_at)

    pgt_updated_at(:o_auth_authentications, :updated_at,
                   function_name: :o_auth_authentications_set_updated_at,
                   trigger_name: :set_updated_at)
  end

  down do
    drop_trigger(:o_auth_authentications, :set_updated_at)
    drop_function(:o_auth_authentications_set_updated_at)
    drop_trigger(:o_auth_authentications, :set_created_at)
    drop_function(:o_auth_authentications_set_created_at)
  end
end
