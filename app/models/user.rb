class User
  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity

  property 'id',        Serial
  property 'name',      String, required: true
  property 'role',      String, required: true, default: 'normal_user'
  property 'time_zone', String

  has n, :authorizations
  has n, :wants
  has n, :haves, 'Have'
  has n, :trades

  attr_protected :role

  def authorized_with(provider)
    self.authorizations.all(provider: provider.to_s).count > 0
  end

  def to_s
    name
  end

  def want_card_names
    wants.collect{|t|t.card_name}
  end

  def have_card_names
    haves.collect{|t|t.card_name}
  end

  def wants_for(user)
    user.wants.all(card_name: have_card_names)
  end

  def trades
    Trade.all(:order => [:updated_at.desc, :created_at.desc])
  end

end

