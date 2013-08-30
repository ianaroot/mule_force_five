Deck.create(name: "dutch_vocab")

CSV.each("nederlands.csv") do |row|
  term       = row.first
  definition = row.last
  Card.create(deck_id: 1, term: term, definition: definition)
end

