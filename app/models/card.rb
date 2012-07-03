class Card
  include DataMapper::Resource

  property :id,    Serial
  property :name,  String,  required: true, index: true, unique: true

  def self.by_name(name)
    all(:name => name)
  end

end
