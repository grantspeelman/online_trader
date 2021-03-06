Sequel.migration do
  up do
    extension :pg_triggers

    pgt_created_at(:wants, :created_at,
                   function_name: :wants_set_created_at,
                   trigger_name: :set_created_at)

    pgt_updated_at(:wants, :updated_at,
                   function_name: :wants_set_updated_at,
                   trigger_name: :set_updated_at)
  end

  down do
    drop_trigger(:wants, :set_updated_at)
    drop_function(:wants_set_updated_at)
    drop_trigger(:wants, :set_created_at)
    drop_function(:wants_set_created_at)
  end
end
