Sequel.migration do
  change do
    run 'CREATE EXTENSION "uuid-ossp"'
  end
end
