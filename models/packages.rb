require 'json'

p "Models"

class Package < Sequel::Model
  def hit!
    self.hits += 1
    self.save(:validate => false)
  end

  def validate
    super
#    errors.add(:url, 'is not correct format') if url !~ /^git:\/\//
    errors.add(:url, 'is not correct format') if url !~ /^(git)|(https):\/\//
  end

  def as_json
    {:name => name, :url => url}
  end

  def to_json(*)
    as_json.to_json
  end
end
