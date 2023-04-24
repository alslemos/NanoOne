// Importações
import Foundation
import AVFoundation

// Variáveis globais para inicialização do jogo
var players: Int = 0   // quantidade de jogadores
var enemies: Int = 0   // quantiade de inimigos
var i: Int = 0         // para iteracoes

var player: AVAudioPlayer? // para tocar os audios
var playersVector: [Player] = [] // vetor para inserir todos os jogadores
var vetorMensagem: [String] = [] // vetor para todas as mensagens


//extensao insere conteúdo dentro do relatório .txt
extension String {
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

//extensao que insere conteúdo dentro do relatório .txt
extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}

// coloca todos os elementos dentro de um texto
func appendNoRelatorio(Texto: String){
    vetorMensagem.append(Texto)
}

//enum que cria estrutura para identificação de erros
enum ErrosJogo: Error{
    case InvalidAmountOfPlayers, InvalidNumberOfPlayerLessThanTwo, InvalidNumberOfEnemyesLessThanOne, MoreWolves
}

//função que randomicamente escolhe o que cada personagem vai ser
func escolhe(playersvector: [Player]) -> Int {
    var amountPlayers: Int = 0
    var choice: Int = 0
    
    for _ in playersvector{
        amountPlayers += 1
    }
    
    repeat {
        choice = Int.random(in: 0..<amountPlayers)
    } while playersvector[choice].player == .wolf
    
    print(choice)
    return choice
}

// mostra os jogadores
func showPlayers(_ playersvector: [Player]){
    print("\nPlayers left:")
    for index in 0..<playersvector.count{
        
        print("Number: \(index + 1)\tName: \(playersvector[index].nome)\tFunction: \(playersvector[index].player?.description ?? "")")
        
        var jogadorTxt = "Number: \(index + 1)\tName: \(playersvector[index].nome)\tFunction: \(playersvector[index].player?.description ?? "")\n"
        
        appendNoRelatorio(Texto: jogadorTxt) // chamada de funcao que coloca tudo no vetor
    }
}


func mostraDia(){
    //interface no terminal
    print("\n\n☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️☁️☀️")
    print("UUUHHHUUUUULLL THE DAY HAS FINALLY ARRIVED!!")
    print("Now, the players will vote to eliminate a player. Which player (number) received the most votes to be eliminated?")
    print("(Press 0 to not kill anyone)")
}


func mostraNoite(){
    //Interface no terminal
    print("\n\n☁️🌙☁️🌙☁️🌙☁️🌙☁️🌙☁️🌙☁️🌙☁️🌙☁️")
    print("UHHHHHH THE NIGHT HAS ARRIVED, RUN FOR YOUR LIFE!")
    print("Now, the wolves will choose who they kill. Which player (number) did the wolves choose?")
    print("(Press 0 if the wolves  not kill anyone)")
}

func noOneDied(){
    //Interface no terminal
    print("\nNo person died during the day!")
    
    var eliminedMessage = "\n\nNo one died during this turn!"
    
    appendNoRelatorio(Texto: eliminedMessage)
}

func musicaDoDia(){
    // musica que toca quando é dia
    guard let url = Bundle.main.url(forResource: "inspiring-cinematic-ambient-116199", withExtension: "mp3") else { return  }
    do {
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let player = player else { return  }
        player.play()
    } catch let error {
        print(error.localizedDescription)
    }
}

func musicaDaNoite(){
    //  Musica que toca quando é noite
    guard let url = Bundle.main.url(forResource: "risk-136788", withExtension: "mp3") else { return }
    do {
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let player = player else { return }
        player.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

func musicaDaVitoria(){
    //  Musica que toca quando o jogo termina
    guard let url = Bundle.main.url(forResource: "success-fanfare-trumpets-6185", withExtension: "mp3") else { return }
    do {
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let player = player else { return  }
        player.play()
    } catch let error {
        print(error.localizedDescription)
    }
}


// funcao dia
func dia(_ playersVector: inout [Player]) -> Bool{
    musicaDoDia() // tocando música
    
    mostraDia() // interface para o host
    
    guard let eliminatedPlayer = Int(readLine() ?? "0")  else {
        print("Invalid Character")
        return false//playersVector
    }
    
    if eliminatedPlayer == 0 {
        return true //retorna já pro while pra ir pro próximo round
    }
    
    if (eliminatedPlayer == 0){
        noOneDied()
        showPlayers(playersVector)
        
    }
    else {
        print("\nThe player \(playersVector[eliminatedPlayer - 1].nome) has been eliminated 💀 of the game!!\n")
        var elimTxt = "\n\nThe player \(playersVector[eliminatedPlayer - 1].nome) has been eliminated 💀 of the game!!\n"
        appendNoRelatorio(Texto: elimTxt)
        playersVector.remove(at: eliminatedPlayer - 1)
        showPlayers(playersVector)
    }
    
    Thread.sleep(forTimeInterval: 1)
    return verifyGame(playersVector)
}

// funcao noite
func noite(_ playersVector: inout [Player]) -> Bool{
    
    musicaDaNoite()
    
    mostraNoite()
    
    //readline para pegar o número do jogador que o lobisomem escolheu
    guard let eliminatedPlayer = Int(readLine() ?? "0")  else {
        print("Invalid Character")
        return false
    }
    print("\nThe player \(playersVector[eliminatedPlayer - 1].nome) has been eliminated 💀 of the game!!\n")
    
    var elimTxt2 = "\n The player \(playersVector[eliminatedPlayer - 1].nome) has been eliminated 💀 of the game!!\n"
    
    appendNoRelatorio(Texto: elimTxt2)
    playersVector.remove(at: eliminatedPlayer - 1)
    showPlayers(playersVector)
    
    Thread.sleep(forTimeInterval: 1)
    return verifyGame(playersVector)
}


// mostra o vencedor
func showWinner(_ playersvector: [Player]){
    musicaDaVitoria()
    
    if playersvector[0].player == .wolf{
        print("WEREWOLFS WON WAUAHAHAHAHAHA 🐺🐺🐺🐺")
    }
    else {
        print("FARMERS WON YAAAAYYYYY 👩‍🌾👩‍🌾👩‍🌾👩‍🌾")
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    let fileName = getDocumentsDirectory().appendingPathComponent("GameReport.txt")
   
    do {
        for index in 0..<vetorMensagem.count{
           
            try vetorMensagem[index].appendToURL(fileURL: fileName)
        }
        
    }catch{
        print("deu ruim")
    }
   

    Thread.sleep(forTimeInterval: 1)
}


// Estrutura jogador
struct Player{
    var nome: String = ""
    var rand: Float = 0.0
    var player: PlayerDescription?
    
}

// estrutura enum para alocacação de função
enum PlayerDescription{
    case wolf
    case farmer
    
    var description: String{
        switch self {
        case .wolf:
            return "🐺"
        case .farmer:
            return "👩‍🌾"
        }
    }
}


// primeira tela
func intro(){
    let nameOfGame: String =  """

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
    print(nameOfGame)
    appendNoRelatorio(Texto: nameOfGame)
    startGame()
}

func readPlayers() throws -> Int {
    guard let players = Int(readLine() ?? "0")  else {
        print("\n⚠️The number entered is invalid. Only number is accept in this part. Please, try again!⚠️")
        throw ErrosJogo.InvalidAmountOfPlayers
    }
    
    if players < 2 {
        print("\n⚠️The number of people to participate in the game must be at least TWO!! Please, try again!⚠️")
        throw ErrosJogo.InvalidNumberOfPlayerLessThanTwo
    }
    
    return players
}

func readEnimies(_ players: Int) throws -> Int {
    print("\nHow many enemies will we have for this campaign? (We recommend 1 to 3)")
    guard let enemies = Int(readLine() ?? "0")  else {
        print("\n⚠️The number entered is invalid. Only number is accept in this part. Please, try again!⚠️")
        throw ErrosJogo.InvalidAmountOfPlayers
    }
    
    if enemies < 1{
        print("\n⚠️The number of wolves must be at least ONE!! Please, try again!⚠️")
        throw ErrosJogo.InvalidNumberOfEnemyesLessThanOne
    }
    
    if enemies >= players{
        print("\n⚠️The number of wolves must be less than the number of farmers!! Please, try again!⚠️")
        throw ErrosJogo.MoreWolves
    }
    
    return enemies
}


// verifica se o jogo ainda pode rolar
func verifyGame(_ playersvector: [Player]) -> Bool{
    var qntwolf: Int = 0
    var qntfarmer: Int = 0
    for player in playersvector {
        if player.player == .farmer{
            qntfarmer += 1
        }
        else if player.player == .wolf{
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

// funcao geral que visa ser o main
func startGame() {
    var players: Int? = nil
    var enemies: Int? = nil
    
    print("Tell us the name of the host, please:")
    
    if let hostName = readLine(){
        print("\nHello, \(hostName), you will be the Host. How many players will we have for this campaign (From 3 to 9)? ")
    }
    
    while (players == nil) {
        players = try? readPlayers()
    }
    print("\nWe will have \(players ?? 0) farmers then, thank you!")
    
    while(enemies == nil) {
        enemies = try? readEnimies(players ?? 0)
    }
    print("\nWe will have \(enemies ?? 0) wolves then, thank you!")
    
    for i in 1...players!{
        
        let auxRand = Float.random(in: 1..<100)
        
        print("\nPlayer \(i) name: ")
        
        let player: Player = Player(nome: readLine() ?? "Empty", rand: auxRand, player: .farmer)
        playersVector.append(player)
    }
    
    // Atribui aleatóriamente os inimigos para os jogadores
    for _ in 1...(enemies ?? 0){
        let villainIndex: Int = escolhe(playersvector: playersVector)
        playersVector[villainIndex].player = .wolf
    }
    
    showPlayers(playersVector) // funcao que mostra os jogadores
    var turn: Int = 1
    
    var turnTxt = "       \n\n   =========== TURN \(turn) =========== \n\n"
    print(turnTxt)
    appendNoRelatorio(Texto: turnTxt)
    
    while noite(&playersVector) && dia(&playersVector){
        turn += 1
        
        var turnTxt2 = "       \n\n   =========== TURN \(turn) =========== \n\n"
        print(turnTxt2)
        
        appendNoRelatorio(Texto: turnTxt2)
        
    }
    // ao final, quando sairmos da condiçao, teremos um ganhador:
    showWinner(playersVector)
}

intro()
