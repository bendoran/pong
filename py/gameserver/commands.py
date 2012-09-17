from twisted.protocols.amp import Command
from twisted.protocols import amp

class Introduce( Command ):
    arguments = [('name', amp.String()),
                 ('x', amp.Integer()),
                 ('y', amp.Integer())]
    response = [('playerId', amp.Integer())]
    
class Position( Command ):
    requiresAnswer = False
    arguments = [('x', amp.Integer()),
                 ('y', amp.Integer())]
    response = [('success', amp.Boolean())]
    
class GetPlayers( Command ):
    requiresAnswer = False
    response = [('success', amp.Boolean())]

class NewPlayer( Command ):
    requiresAnswer = False
    arguments = [('player', amp.Integer())]
    response = [('success', amp.Boolean())]
    
class PlayerLeft( Command ):
    requiresAnswer = False
    arguments = [('player', amp.Integer())]
    response = [('success', amp.Boolean())]
    