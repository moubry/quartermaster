class Deck
  attr_accessor :title, :author, :intro, :filename, :cards

  def initialize(attrs = {})
    attrs.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
end
