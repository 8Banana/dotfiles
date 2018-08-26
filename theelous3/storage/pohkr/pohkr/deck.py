from enum import IntEnum, Enum


class Suits(IntEnum):
    SPADES = 1
    HEARTS = 2
    DIAMONDS = 3
    CLUBS = 4


suits_symbols = {
    Suits.SPADES: '♠',
    Suits.HEARTS: '♥',
    Suits.DIAMONDS: '♦',
    Suits.CLUBS: '♣'
}


class Cards(IntEnum):
    ACE = 14
    KING = 13
    QUEEN = 12
    JACK = 11
    TEN = 10
    NINE = 9
    EIGHT = 8
    SEVEN = 7
    SIX = 6
    FIVE = 5
    FOUR = 4
    THREE = 3
    TWO = 2


card_symbols = {
    Cards.ACE: 'A',
    Cards.KING: 'K',
    Cards.QUEEN: 'Q',
    Cards.JACK: 'J',
    Cards.TEN: '10',
    Cards.NINE: '9',
    Cards.EIGHT: '8',
    Cards.SEVEN: '7',
    Cards.SIX: '6',
    Cards.FIVE: '5',
    Cards.FOUR: '4',
    Cards.THREE: '3',
    Cards.TWO: '2'
}

deck = []

for suit in Suits:
    deck.extend([(card, suit) for card in Cards])
