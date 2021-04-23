/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
// Globais
import class SpriteKit.SKScene
import class SpriteKit.SKLabelNode
import class SpriteKit.SKView
import class SpriteKit.SKAction

import struct SpriteKit.TimeInterval
import struct SpriteKit.CGSize
import struct SpriteKit.CGFloat
import struct SpriteKit.CGPoint

import func SpriteKit.sqrt
import func SpriteKit.pow

// Locais
import class Modules.Particle


/**
    # Ação e funcionamento do jogo
    Toda a lógica e funcionamento do jogo está nessa classe.

    ## Atributos
    
    |     Atributos     |                                    Descrição                                  |
    |:------------------|:------------------------------------------------------------------------------|
    | allParticles      | Lista com todas as partículas vermelhas.                                      |
    | specialParticle   | Lista com todas as partículas verdes (especiais).                             |
    | userNode          | Partícula que o usuário controla.                                             |
    | gameOn            | Verifica se o jogo já começou.                                                |
    | gameStart         | Incialização do jogo.                                                         |
    | lbClock           | Label do cronômetro.                                                          |
    | lbNotification    | Label da notificação de início e final de jogo.                               |
    | renderTime        | Tempo de renderização do fps                                                  |
    | gameTime          | Cronômetro.                                                                   |
    | specialTime       | Momento de criação das bolinhas especiais.                                    |
    | isDragging        | Verifica se está movendo a bolinha do usuário.                                |
    | scaleTime         | Aumento da escala da bolinha (quando nasce) em relação ao tempo (segundos).   |
    |-------------------|-------------------------------------------------------------------------------|
    
    ## Métodos
    
    |      Métodos      |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | didMove           | Configurações de quando a cena é carregada.       |
    | didChangeSize     | Configurações da tela.                            |
    | update            | Configuração e ação de cada frame (fps).          |
    | createNode        | Criação e configuração inicial de uma partícula.  |
    | moveParticles     | Movimentação das partículas.                      |
    | clear             | Limpa a tela (ação das bolinhas verdes).          |
    | startDrag         | Ação de quando clica na tela.                     |
    | drag              | Ação de quando arrasta com o click pressionado.   |
    | drop              | Ação de quando solta o click.                     |
    | getDistance       | Cálculo da distância entre dois pontos.           |
    |-------------------|---------------------------------------------------|
*/
public class GameScene: SKScene {
    // Atributos da classe
    var allParticles:[Particle] = []
    var specialParticles:[Particle] = []
    var userNode:Particle = Particle()
    var gameOn:Bool = false
    var gameStart:Bool = true
    var lbClock:SKLabelNode = SKLabelNode()
    var lbNotification:SKLabelNode = SKLabelNode()
    var renderTime:TimeInterval = 0.0
    var gameTime:Int = 0
    var specialTime:Int = 4
    var isDragging:Bool = false
    var scaleTime:TimeInterval = 1
    
    /** 
        # Método [lifecycle]: 
        Toda vez que a tela é carregada (inicializada) essas configuraçôes serão feitas.
    */
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.backgroundColor = #colorLiteral(red: 0.976, green: 0.8185917735099792, blue: 0.6586142182350159, alpha: 1.0)
        
        self.userNode.setUserColor()
        
        self.lbClock.fontColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) 
        self.lbClock.fontSize = 60
        self.lbClock.text = "0"
        
        self.lbNotification.fontColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) 
        self.lbNotification.fontSize = 40
        self.lbNotification.text = "SWIPE THE BALL TO PLAY"
        
        self.addChild(self.userNode.getNode())
        self.addChild(self.lbClock)
        self.addChild(self.lbNotification)
    }
    

    /** 
        # Método [lifecycle]: 
        Configurações feitas quando tem alguma alteração no tamanho de tela.
    */
    public override func didChangeSize(_ oldSize: CGSize) {
        self.userNode.setPositions(self.size.width / 2, self.size.height / 2)
        self.lbClock.position.x = self.size.width / 2
        self.lbClock.position.y = self.size.height - 60
        
        self.lbNotification.position.x = self.size.width / 2
        self.lbNotification.position.y = (self.size.height / 2) / 2
    }
    

    /** 
        # Método [lifecycle]: 
        Ação de cada frame que acontece (fps).
    */
    public override func update(_ currentTime: TimeInterval) {
        if (self.gameOn) {  
            self.gameStart = false
            // Tempo/cronômetro:
            if (currentTime > self.renderTime) {
                self.gameTime += 1
                self.lbClock.text = "\(self.gameTime)"
                self.renderTime = currentTime + 1
                
                // Criando as bolinhas:
                for i in 0..<abs(self.gameTime/2){
                    self.createNode(isSpecial_: false)
                }
                
                // Criando a bolinha especial
                if (self.gameTime == self.specialTime) {
                    if (self.specialParticles.count != 3) { 
                        self.createNode(isSpecial_: true)
                    }
                    self.specialTime += 4
                }
                for p in self.allParticles.reversed() {
                    if (p.isAlive()) {p.setLifeTime(1)}
                    else {break}
                }
            }
            moveParticles()
        } else if (self.gameStart){
            var uPos = self.userNode.getPositions()
            if ((uPos[0] != self.size.width/2) && (uPos[1] != self.size.height/2)) {
                self.gameOn = true
                self.lbNotification.removeFromParent()
                self.gameStart = false
            }
        }
    }
    
    // Cria as bolinhas na tela
    /** 
        # Método: 
        Criação e configuração inicial das bolinhas

        ## Parâmetro:
        `Bool` isSpecial_: `true` pra esepcial ou `false` para comum.
    */
    func createNode(isSpecial_:Bool) {
        var p = Particle()
        // Define a posição da bolinha
        var x = CGFloat.random(in: 0...self.size.width)
        var y = CGFloat.random(in: 0...self.size.height-40)
        p.setPositions(x, y) 
        
        // Define o tempo da bolinha
        p.setInitialTime(self.gameTime)
        
        // Coloca na tela e guarda no vetor
        self.addChild(p.getNode())
        self.allParticles.append(p)
        
        // Caso seja uma bolinha especial
        if (isSpecial_) {
            p.setSpecialColor()
            self.specialParticles.append(p)
        }
    }
    
    
    /** 
        # Método: 
        Configuração do movimento das bolinhas.
    */
    func moveParticles() -> Void {
        // Posição atual do UserNode
        var uPos = self.userNode.getPositions()
        var act = SKAction.move(to: CGPoint(x: uPos[0] , y: uPos[1]), duration: 3)
        
        // Movimentação das bolinhas
        for p in self.allParticles.reversed() {
            if (p.isAlive()) {
                var pos = p.getPositions()
                
                // Especial
                if (p.isSpecialNode()) {
                    if (getDistance(pos, uPos)-self.userNode.getRadius() < self.userNode.getRadius()) {
                        for s in 0..<self.specialParticles.count{
                            if (self.specialParticles[s].getInitialTime() == p.getInitialTime()) {
                                self.specialParticles.remove(at: s)
                                break
                            }
                        }
                        self.clear()
                        return
                    }; continue
                } 
                
                // Comum
                if (p.isReady()) {                      // Perseguindo
                    // Parada do jogo
                    if ((getDistance(pos, uPos)-self.userNode.getRadius()-3) < self.userNode.getRadius()) {
                        self.gameOn = false
                        self.lbNotification.text = "GAME OVER"
                        self.addChild(self.lbNotification)
                        self.lbNotification.position.y = (self.size.height / 2)
                        return
                    }
                    
                    if p.getScale() != CGFloat(1) {p.setScale(1)}
                    p.setRun(act)
                } else {p.setScale(p.getScale()+0.01)}  // Nascendo
            } else {return}
        }
    }
    
    
    /** 
        # Método: 
        Ação das bolinhas verdes: tira todas as bolinhas (partículas/node) vermelhas da tela.
    */
    func clear() -> Void{
        for p in self.allParticles.reversed(){
            if (!p.isAlive()) {break}
            p.setAlive(false)
            p.getNode().removeAllActions()
        }
        self.removeAllChildren()
        for s in specialParticles {
            s.setAlive(true)
            self.addChild(s.getNode())
            self.allParticles.append(s)
        }
        self.addChild(self.userNode.getNode())
        self.addChild(self.lbClock)
    }
    
    /* Movimentando a bolinha com o mouse (node) */
    
    /** 
        # Método: 
        Ação de quando clica na tela.
    */
    func startDrag(_ pos_:[CGFloat]) -> Void {
        if (self.gameOn || self.gameStart) {self.isDragging = true}
    }
    
    /** 
        # Método: 
        Ação de quando arrasta algo na tela.
    */
    func drag(_ pos_:[CGFloat]) -> Void{
        if ((self.gameOn && self.isDragging) || (self.gameStart)) {
            if (pos_[0] < 0 && pos_[1] < 0) {            // 3º Quadrante (x e y são negativos)
                self.userNode.setPositions(0, 0)
            } else if (pos_[0] < 0) {                    // Canto esquerdo
                if pos_[1] > self.size.height{
                    self.userNode.setPositions(0, self.size.height)
                }else{
                    self.userNode.setPositions(0, pos_[1])
                }
            } else if (pos_[1] < 0) {                    // Canto de baixo
                if pos_[0] > self.size.width{
                    self.userNode.setPositions(self.size.width, 0)
                }else{
                    self.userNode.setPositions(pos_[0], 0)
                }
            } else if (pos_[0] > self.size.width) {      // Canto direito
                if pos_[1] > self.size.height{
                    self.userNode.setPositions(self.size.width, self.size.height)
                }else{
                    self.userNode.setPositions(self.size.width, pos_[1])
                }
            } else if (pos_[1] > self.size.height) {     // Canto de cima
                if pos_[0] > self.size.width{
                    self.userNode.setPositions(self.size.width, self.size.height)
                }else{
                    self.userNode.setPositions(pos_[0], self.size.height)
                }
            } else {                                     // Qualquer posição da tela
                self.userNode.setPositions(pos_[0], pos_[1])
            }
        }
    }
    
    /** 
        # Método: 
        Ação de quando para de clicar na tela.
    */
    func drop()-> Void {self.isDragging = false}
    
    /** 
        # Método: 
        Pega a distância entre dois os pontos.
    */
    func getDistance(_ n1_:[CGFloat], _ n2_:[CGFloat]) -> CGFloat {
        return CGFloat(sqrt(pow(n1_[0] - n2_[0], 2) + pow(n1_[1] - n2_[1], 2)))
    }
}