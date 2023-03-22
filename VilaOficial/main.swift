import Foundation
import AVFoundation


var players: Int = 0
var enemies: Int = 0
var i: Int = 0
var playersVector: [Player] = [] // Criando vetor para inserir todos os players

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
    var choice: Int = 0
    for _ in playersvector{
    amountPlayers += 1
    }
    repeat {
       choice = Int.random(in: 0..<amountPlayers)
    }while playersvector[choice].player == .enemye
    print(choice)
    return choice
}

//func Intro(){
//
//    let _: String =  """
//  🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾
// VVVVVVVV           VVVVVVVV  iiii  lllllll
// V::::::V           V::::::V i::::i l:::::l
// V::::::V           V::::::V  iiii  l:::::l
// V::::::V           V::::::V        l:::::l
//  V:::::V           V:::::V iiiiiii  l::::l   aaaaaaaaaaaaa
//   V:::::V         V:::::V  i:::::i  l::::l   a::::::::::::a
//    V:::::V       V:::::V    i::::i  l::::l   aaaaaaaaa:::::a
//     V:::::V     V:::::V     i::::i  l::::l            a::::a
//      V:::::V   V:::::V      i::::i  l::::l     aaaaaaa:::::a
//       V:::::V V:::::V       i::::i  l::::l   aa::::::::::::a
//        V:::::V:::::V        i::::i  l::::l  a::::aaaa::::::a
//         V:::::::::V         i::::i  l::::l a::::a    a:::::a
//          V:::::::V         i::::::il::::::la::::a    a:::::a
//           V:::::V          i::::::il::::::la:::::aaaa::::::a
//            V:::V           i::::::il::::::l a::::::::::aa:::a
//             VVV            iiiiiiiillllllll  aaaaaaaaaa  aaaa
//
//  🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾🐺👩‍🌾
//"""
//    var b = Carrega()
//}



// funcao geral que visa ser o main
func Carrega() -> Int{
    print("🐺🌕🐺🌕  Vila  🐺🌕🐺🌕 \n\n\n")
    
    print("Tell us the name of the host, please:")
    
    if let masterName = readLine() {
        print("\n Hello, \(masterName), you will be the master. How many players will we have for this campaign?")
    }
    
    guard let players = Int(readLine() ?? "0")  else {  // unwrapping
        print("nao rolou")
        return 0
    }
    print("We will have \(players) then, thank you")
    
    print("How many enemies will we have for this campaign?")
    guard let enemies = Int(readLine() ?? "0")  else {  // unwrapping
        print("nao rolou inimigo")
        return 0
    }
    print("We will have \(enemies) then, thank you")
        
    for i in 1...players{
        
        var auxRand = Float.random(in: 1..<100) // pq esse underline?
        // print(auxRand)  Já sabemos que funciona
        
        print("Player \(i) name: ") // coerente
        
        var a: Player = Player(nome: readLine() ?? "Empty", rand: auxRand, player: .farmer) // mui
        
        playersVector.append(a)

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
    
    
    while playersVector.count > 2{  // logica ainda nao esta coerente, mas coisa para amanhã
        noite(&playersVector)
        dia(&playersVector)
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
