require 'rspec/autorun'
require_relative '../app/deck.rb'

describe Deck, 'when first created' do
  attrs = [
    :title,
    :author,
    :intro,
    :filename
  ]

  attrs.each do |attr|
    it 'has a nil #{attr}' do
      expect(subject.send(attr)).to eql(nil)
    end
  end
end

describe Deck, 'initialized with attributes' do
  attrs = {
    title: 'Ruby on Rails',
    author: 'Sean Moubry',
    intro: '<p>Ruby is a programming language.</p><p>Rails is a web framework.</p>',
    filename: 'ruby_on_rails.md'
  }

  subject { Deck.new(attrs) }

  attrs.each do |attr, value|
    it "has the correct #{attr}" do
      expect(subject.send(attr)).to eql(value)
    end
  end
end
