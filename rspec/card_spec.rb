require 'rspec/autorun'
require_relative '../app/card.rb'

describe Card, 'when first created' do
  attrs = [
    :category,
    :front,
    :back
  ]

  attrs.each do |attr|
    it 'has a nil #{attr}' do
      expect(subject.send(attr)).to eql(nil)
    end
  end
end

describe Card, 'initialized with attributes' do
  attrs = {
    front: '<h3>Should Ruby code have lots of comments?</h3>',
    back: '<p>No.</p><p>Good code is like a good joke.</p>'
  }

  subject { Card.new(attrs) }

  attrs.each do |attr, value|
    it "has the correct #{attr}" do
      expect(subject.send(attr)).to eql(value)
    end
  end
end

describe Card, 'back' do
  it 'can appended to' do
    card = Card.new(back: 'foo')
    card.add_to_back('bar')
    expect(card.back).to eql('foobar')
  end

  it 'can be appended to nil' do
    card = Card.new(back: nil)
    card.add_to_back('lorem')
    expect(card.back).to eql('lorem')
  end

  it 'can be appended multiple times' do
    card = Card.new
    card.add_to_back('o')
    card.add_to_back('m')
    card.add_to_back('g')
    expect(card.back).to eql('omg')
  end
end

describe Card, 'hash' do
  it 'returns a hash representation itself' do
    attrs = { category: 'zoom', front: 'foo', back: 'bar' }
    card = Card.new(attrs)
    expect(card.hash).to eql(attrs)
  end
end

describe Card, 'equals operator' do
  it 'returns true for two equal instances (new)' do
    card1 = Card.new
    card2 = Card.new
    expect(card1).to eql(card2)
  end
  it 'returns true for two equal instances (same attrs)' do
    card1 = Card.new(front: 'foo', back: 'bar')
    card2 = Card.new(front: 'foo', back: 'bar')
    expect(card1).to eql(card2)
  end
  it 'returns false for equal for shared attrs but not exactly same' do
    card1 = Card.new(category: 'zoom', front: 'foo', back: 'bar')
    card2 = Card.new(front: 'foo', back: 'bar')
    expect(card1).to_not eql(card2)
  end
  it 'returns false for instances where fronts do not match' do
    card1 = Card.new(front: 'foo', back: 'bar')
    card2 = Card.new(front: 'nope', back: 'bar')
    expect(card1).to_not eql(card2)
  end
  it 'returns false for instances where backs do not match' do
    card1 = Card.new(front: 'foo', back: 'bar')
    card2 = Card.new(front: 'nope', back: 'nope')
    expect(card1).to_not eql(card2)
  end
end
