from twisted.protocols.amp import AMP
from twisted.internet.protocol import ServerFactory
from commands import Introduce
from gameserver.commands import Position, NewPlayer, PlayerLeft, GetPlayers

class GameServer( AMP ):
    def __init__(self, game ):
        self.game = game
        self.player = None
        
    def introduce(self, name, x, y ):
        self.player = self.game.createPlayer( name, self )
        self.player.setPosition( x, y )
        return { 'playerId' : self.player.playerId }
    Introduce.responder( introduce )
    
    def position(self, x, y ):
        if self.player :
            self.player.setPosition( x, y )
            success = True
        else:
            success = False
        return { 'success' : success }  
    Position.responder( position )
    
    def getPlayers(self):
        for otherPlayer in self.game.players :
            if otherPlayer != self.player :
                self.callRemote( NewPlayer, player=otherPlayer.playerId )
        return { 'success' : True }  
    GetPlayers.responder( getPlayers )
    
    def connectionLost(self, reason):
        self.game.removePlayer( self.player )
        AMP.connectionLost(self, reason)
        
class Game():
    def __init__(self):
        self.players = [];
        
    def createPlayer(self, name, client ):
        print "Creating player: %s" % name
        player = Player( len( self.players ), name, client )
        self.players.append( player )
        print "Num Players: %s" % len( self.players )
        for otherPlayer in self.players :
            if otherPlayer != player :
                otherPlayer.client.callRemote( NewPlayer, player=player.playerId )
        return player    
    
    def removePlayer(self, player ):
        print "Removing player: %s " % player.name
        self.players.remove( player )
        for otherPlayer in self.players :
            if otherPlayer != player :
                otherPlayer.client.callRemote( PlayerLeft, player=player.playerId )
        print "Num Players: %s" % len( self.players )
        
class Player():
    def __init__(self, playerId, name, client ):
        self.playerId = playerId
        self.name = name
        self.client = client
        self.x = 0;
        self.y = 0;
    
    def setPosition(self, x, y ):
        print "Setting position: %s %s" % (x,y)
        self.x = x;
        self.y = y;
        
class GameFactory( ServerFactory ):
    
    def __init__(self, game ):
        self.game = game
        
    def buildProtocol(self, ignored):
        return GameServer( self.game )
