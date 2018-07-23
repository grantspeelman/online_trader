DataMapper::Validations::OrderedHash.class_eval do
  def full_messages_for(name)
    self[name.to_sym]
  end
end