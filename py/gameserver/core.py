from gameserver.server import GameFactory, Game
from twisted.internet import protocol, reactor

def run():
    game = Game()
    reactor.listenTCP( 6000, GameFactory( game ) )
    reactor.run()
