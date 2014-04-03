require 'rspec/autorun'
require_relative '../app/deck_cutter.rb'
require_relative '../app/deck.rb'

describe DeckCutter, 'from_elements' do

  context 'when elements start with an h1' do

    it 'extracts the header and returns a deck' do
      elements = [
        double(name: 'h1', to_html: '<h1>MacRuby</h1>'),
        double(name: 'p', to_html: '<p>Author: Sean Moubry</p>'),
        double(name: 'p',  to_html: '<p>This deck teaches the fundamentals of MacRuby.</p>')
      ]

      expect(Deck.from_elements(elements)).to eql(
        Deck.new(
          title: '<h1>MacRuby</h1>',
          intro: '<p>Author: Sean Moubry</p><p>This deck teaches the fundamentals of MacRuby.</p>',
          filename: nil,
          cards: nil
        )
      )
    end

  end

  it 'returns nil from empty string' do
    elz = []
    expect(DeckCutter.from_elements(elz)).to eql(nil)
  end

  it 'returns nil from nil' do
    elz = []
    expect(DeckCutter.from_elements(elz)).to eql(nil)
  end

end
