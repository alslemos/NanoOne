import Foundation


var players: Int = 0
var enemies: Int = 0
var i: Int = 0

enum PlayerDescription{
    case enemye
    case farmer
    //case magician
    //case Diretor
    //case Assistente
    
    var description: String{
        switch self {
        case .enemye:
            return "🐺🌕🐺🌕🐺"
        case .farmer:
            return "👩‍🌾🥕👩‍🌾🥕"
        default:
            print("Opa!")
        }
    }
}

struct Player{
    var nome: String = ""
    var rand: Float = 0.0
    var player: PlayerDescription? // como eles começam o jogo sem, pode ser interessante!
    
}

//parte da Raquel
//função que escolhe o que cada personagem vai ser
func escolhe(playersvector: [Player]) -> Int {
    var amountPlayers: Int = 0
    
    for _ in playersvector{
    amountPlayers += 1
    }
    var choice: Int = Int.random(in: 0..<amountPlayers)
    print(choice)
    return choice
}


// funcao geral que visa ser o main
func Carrega() -> Int{
    print("Tell us the name of the host, please:")
    
    if let masterName = readLine() {
        print("Hello, \(masterName), you will be the master. How many players will we have for this campaign?")
    }
    
    guard let players = Int(readLine() ?? "0")  else {  // unwrapping
        print("nao rolou")
        return 0
    }
    print("We will have \(players) then, thank you")
    
    
    guard let enemies = Int(readLine() ?? "0")  else {  // unwrapping
        print("nao rolou inimigo")
        return 0
    }
    print("We will have \(enemies) then, thank you")
    
    
    // Criando vetor para inserir todos os players
    var playersVector: [Player] = [] // pq esse underline?
    
    print(players)
    
    for i in 1...players{
        
        var auxRand = Float.random(in: 1..<100) // pq esse underline?
        print(auxRand)
        
        print("Player \(i) name: ") // coerente
        
        var a: Player = Player(nome: readLine() ?? "Empty", rand: auxRand, player: .farmer) // mui
        
        playersVector.append(a)
        // nao vai funcionar
        
        
    }
    //parte de testes da raquel
    for _ in 0...enemies{
        var villainIndex: Int = escolhe(playersvector: playersVector)
        playersVector[villainIndex].player = .enemye

    }
    
    //teste para ver se funcionou
    var j: Int = 0
    for _ in playersVector{
        print(playersVector[j].player)
        j += 1
    }
    
    return 5
    
    
}

var b = Carrega() // chamando o que seria a nossa função main
//playersVector[i] = Player(nome: readLine() ?? "Empty", rand: auxRand, player: .farmer) // muito manual

func dia(_ playersVector: inout [Player]) -> [Player]{
    print("UHHHHHH GRAÇAS AO BOM GOD O DIA CHEGOU")
    print("Now, the players will vote to eliminate a player:")
    print("Which player received the most votes to be eliminated?")
    
    guard let eliminatedPlayer = Int(readLine() ?? "0")  else {  // unwrapping
        print("Invalid Character")
        return playersVector
    }
    
    print("The player \(playersVector[eliminatedPlayer - 1].nome) has been eliminated of the game!!")
    playersVector.remove(at: eliminatedPlayer - 1)//Como limpar a posição do vetor
    return playersVector
}

func noite(_ playersVector: inout [Player]) -> [Player]{
    print("UHHHHHH A NOITE CHEGOU, CORRAAAAAAA!")
    print("Now, the wolves will choose who they kill:")
    print("Which play did the wolves decide to kill?")

    guard let eliminatedPlayer = Int(readLine() ?? "0")  else {  // unwrapping
        print("Invalid Character")
        return playersVector
    }

    print("The player \(playersVector[eliminatedPlayer - 1].nome) has been eliminated of the game!!")
    playersVector.remove(at: eliminatedPlayer - 1) //Como limpar a posição do vetor
    return playersVector
}

