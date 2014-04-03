class Card
  attr_accessor :category, :front, :back

  def initialize(attrs = {})
    attrs.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def add_to_back(content)
    @back = '' unless @back
    @back << content
  end

  def ==(other)
    hash.all? { |k, v| hash[k] == other.hash[k] }
  end
  alias_method :eql?, :==

  def hash
    {
      category: @category,
      front: @front,
      back: @back
    }
  end
end
