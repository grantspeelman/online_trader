Sequel.migration do
  up do
    extension :pg_triggers

    pgt_created_at(:haves, :created_at,
                   function_name: :haves_set_created_at,
                   trigger_name: :set_created_at)

    pgt_updated_at(:haves, :updated_at,
                   function_name: :haves_set_updated_at,
                   trigger_name: :set_updated_at)
  end

  down do
    drop_trigger(:haves, :set_updated_at)
    drop_function(:haves_set_updated_at)
    drop_trigger(:haves, :set_created_at)
    drop_function(:haves_set_created_at)
  end
end
