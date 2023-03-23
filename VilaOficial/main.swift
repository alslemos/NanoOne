// Importações
import Foundation
import AVFoundation

// Variáveis globais para inicialização do jogo
var players: Int = 0
var enemies: Int = 0
var i: Int = 0

var player: AVAudioPlayer? // para tocar os audios
var playersVector: [Player] = [] // vetor para inserir todos os jogadores


//função que randomicamente escolhe o que cada personagem vai ser
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

// mostra os jogadores
func showPlayers(_ playersvector: [Player]){
    for index in 0..<playersvector.count{
        print("Number: \(index + 1)\tName: \(playersvector[index].nome)\tFunction: \(playersvector[index].player?.description ?? "")")
    }
}


// funcao dia
func dia(_ playersVector: inout [Player]) -> Bool{
    guard let url = Bundle.main.url(forResource: "inspiring-cinematic-ambient-116199", withExtension: "mp3") else { return true } //tirei o return daqui de dentro
           do {
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
               guard let player = player else { return false } //tirei o return daqui de dentro
               player.play()
           } catch let error {
               print(error.localizedDescription)
           }
    //var b = readLine()// nao mata a musica
    
    print("\n\n☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️")
    print("UHHHHHH GRAÇAS AO BOM GOD O DIA CHEGOU")
    print("Now, the players will vote to eliminate a player:")
    print("Which player received the most votes to be eliminated?")
    
    guard let eliminatedPlayer = Int(readLine() ?? "0")  else {  // unwrapping
        print("Invalid Character")
        return false//playersVector
    }
    
    print("The player \(playersVector[eliminatedPlayer - 1].nome) has been eliminated 💀 of the game!!\n")
    playersVector.remove(at: eliminatedPlayer - 1)//Como limpar a posição do vetor
    showPlayers(playersVector)
    //return real oficial
    //    var a = readLine()
    Thread.sleep(forTimeInterval: 1)
    return verifyGame(playersVector)
    //return playersVector
}

// funcao noite
func noite(_ playersVector: inout [Player]) -> Bool{
    //  Musica da noite
           guard let url = Bundle.main.url(forResource: "risk-136788", withExtension: "mp3") else { return true} //tirei o return daqui de dentro
           do {
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
               guard let player = player else { return false } //tirei o return daqui de dentro
               player.play()
               
           } catch let error {
               print(error.localizedDescription)
           }
    
    print("\n\n☁️🌙☁️🌙☁️🌙☁️🌙☁️🌙☁️🌙☁️🌙☁️🌙☁️")
    print("UHHHHHH A NOITE CHEGOU, CORRAAAAAAA!")
    print("Now, the wolves will choose who they kill:")
    print("Which player did the wolves decide to kill?")

    guard let eliminatedPlayer = Int(readLine() ?? "0")  else {  // unwrapping
        print("Invalid Character")
        return false//playersVector
    }

    print("The player \(playersVector[eliminatedPlayer - 1].nome) has been eliminated 💀 of the game!!\n")
    playersVector.remove(at: eliminatedPlayer - 1) //Como limpar a posição do vetor
    showPlayers(playersVector)
    
    // trocando readLine()
    Thread.sleep(forTimeInterval: 1)
    return verifyGame(playersVector)
}


// mostra o vencedor
func showWinner(_ playersvector: [Player]){
    
    guard let url = Bundle.main.url(forResource: "success-fanfare-trumpets-6185", withExtension: "mp3") else { return  } //tirei o return daqui de dentro
           do {
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
               guard let player = player else { return  } //tirei o return daqui de dentro
               player.play()
           } catch let error {
               print(error.localizedDescription)
           }
    
    
    if playersvector[0].player == .enemye{
        print("WEREWOLFS WON WAUAHAHAHAHAHA 🐺🐺🐺🐺")
    }
    else {
        print("FARMERS WON YAAAAYYYYY 👩‍🌾👩‍🌾👩‍🌾👩‍🌾")
    }
    
    Thread.sleep(forTimeInterval: 1)
    
}


// Estrutura jogador
struct Player{
    var nome: String = ""
    var rand: Float = 0.0
    var player: PlayerDescription? // como eles começam o jogo sem, pode ser interessante!
    
}

// estrutura enum para alocacação de função
enum PlayerDescription{
    case enemye
    case farmer
    //case magician
    //case Diretor
    //case Assistente
    
    var description: String{
        switch self {
        case .enemye:
            return "🐺"
        case .farmer:
            return "👩‍🌾"
        default:
            print("Opção Default!")
        }
    }
}


// primeira tela
func intro(){
    let a: String =  """

  🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺
 VVVVVVVV           VVVVVVVV  iiii  lllllll
 V::::::V           V::::::V i::::i l:::::l
 V::::::V           V::::::V  iiii  l:::::l
 V::::::V           V::::::V        l:::::l
  V:::::V           V:::::V iiiiiii  l::::l   aaaaaaaaaaaaa
   V:::::V         V:::::V  i:::::i  l::::l   a::::::::::::a
    V:::::V       V:::::V    i::::i  l::::l   aaaaaaaaa:::::a
     V:::::V     V:::::V     i::::i  l::::l            a::::a
      V:::::V   V:::::V      i::::i  l::::l     aaaaaaa:::::a
       V:::::V V:::::V       i::::i  l::::l   aa::::::::::::a
        V:::::V:::::V        i::::i  l::::l  a::::aaaa::::::a
         V:::::::::V         i::::i  l::::l a::::a    a:::::a
          V:::::::V         i::::::il::::::la::::a    a:::::a
           V:::::V          i::::::il::::::la:::::aaaa::::::a
            V:::V           i::::::il::::::l a::::::::::aa:::a
             VVV            iiiiiiiillllllll  aaaaaaaaaa  aaaa

  🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺 👩‍🌾 🐺

"""
    print(a)
    carrega() // chamando o equivalente a funcão main
}

// funcao geral que visa ser o main
func carrega() -> Int{
    print("Tell us the name of the host, please:")
    
    if let masterName = readLine() {
        print("\nHello, \(masterName), you will be the master. How many players will we have for this campaign (From 3 to 9)? ")
    }
    
    guard let players = Int(readLine() ?? "0")  else {  // unwrapping
        print("nao rolou")
        return 0
    }
    print("We will have \(players) then, thank you")
    
    print("How many enemies will we have for this campaign? (We recommend 1 to 3)")
    guard let enemies = Int(readLine() ?? "0")  else {  // unwrapping
        print("nao rolou inimigo")
        return 0
    }
    print("We will have \(enemies) then, thank you")
        
    for i in 1...players{
        
        var auxRand = Float.random(in: 1..<100) // pq esse underline?
        // print(auxRand)  Já sabemos que funciona
        
        print("\nPlayer \(i) name: ") // coerente
        
        var a: Player = Player(nome: readLine() ?? "Empty", rand: auxRand, player: .farmer) // mui
        
        playersVector.append(a)

    }
    
    //parte de testes da raquel
    for _ in 1...enemies{
        var villainIndex: Int = escolhe(playersvector: playersVector)
        playersVector[villainIndex].player = .enemye

    }
    
    //teste para ver se funcionou
//    var j: Int = 0
//    for _ in playersVector{
//        print(playersVector[j].player)
//        j += 1
//    }
    
    showPlayers(playersVector) // funcao que mostra os jogadores
    
    //MARK: - contagem de quantas pessoas e quantos lobos
    //a condição preisa refletir a qnt de jogadores e de lobos
//    repeat{  // logica ainda nao esta coerente, mas coisa para amanhã
//        noite(&playersVector)
//        showPlayers(playersVector)
//        dia(&playersVector)
//        showPlayers(playersVector)
//
//    }while contplayers(playersVector)
    while noite(&playersVector) && dia(&playersVector){
        print("OUTRO TURNO")
    }
    print("O JOGO ACABOU")
    showWinner(playersVector)
    return 5 // pq 5? n sabemos
}

// verifica se o jogo ainda pode rolar
func verifyGame(_ playersvector: [Player]) -> Bool{
    var qntwolf: Int = 0
    var qntfarmer: Int = 0
    for player in playersvector {
        if player.player == .farmer{
            qntfarmer += 1
        }
        else if player.player == .enemye{
            qntwolf += 1
        }
    }
    if qntwolf == 0 || qntfarmer == 0 {
        return false
    }
    else {
        return true
    }
    
}

// chamada da funcao intro (nosso main)
intro()
