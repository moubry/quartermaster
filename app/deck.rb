class Deck
  attr_accessor :title, :author, :intro, :filename

  def initialize(attrs)
    @title = attrs[:title]
    @author = attrs[:author]
    @intro = attrs[:intro]
    @filename = attrs[:filename]
  end
end
