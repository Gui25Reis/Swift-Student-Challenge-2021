import  SpriteKit

public class ArtScene: SKScene {
    // Atributos da classe
    var allParticles:[Particle] = []
    var userNode:Particle = Particle()
    var gameOn:Bool = false
    var oldSize:[CGFloat] = [0 , 0]
    
    // didMove: Mostra algo na tela
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = #colorLiteral(red: 0.0, green: 0.4293115139, blue: 0.5599628091, alpha: 1.0)
        
        for i in 0..<10 {
            var p = Particle()
            self.addChild(p.getNode())
            allParticles.append(p)
        }
        
        self.userNode.setUserColor()
        self.addChild(self.userNode.getNode())
    }
    
    // Método chamado toda vez que muda o tamanho da tela
    // _ : quando chamar a função n vai precisar coloca o nome do parâmetro, apenas o valor 
    public override func didChangeSize(_ oldSize: CGSize) {
        if (self.oldSize[0] > 2) { 
            if (!self.gameOn) {
                for p in allParticles { 
                    var x = CGFloat.random(in: 0...self.size.width)
                    var y = CGFloat.random(in: 0...self.size.height)
                    p.setPositions(x, y)
                }
                self.userNode.setPositions(self.size.width / 2, self.size.height / 2)
                self.gameOn = true
            } else {
                for p in allParticles {
                    setNewPosition(p_: p)
                }
                setNewPosition(p_: userNode)
            }
        }
        self.oldSize = [self.size.width, self.size.height]
        print(self.oldSize)
    }
    
    // Método: atualiza a janela
    public override func update(_ currentTime: TimeInterval) {
        var uPositions = self.userNode.getPositions()
        self.userNode.setPositions(uPositions[0]+0.3, uPositions[1])
        
        var userNodePosition = CGPoint(x: uPositions[0] , y: uPositions[1])
        var act = SKAction.move(to: userNodePosition, duration: 8)
        
        uPositions = self.userNode.getPositions()
        for p in 0..<allParticles.count{
            var pos = allParticles[p].getPositions()
            allParticles[p].setRun(act)
            
            if getDistance(n1_: pos, n2_: uPositions)-17 < self.userNode.getRadius(){
                allParticles.remove(at: p)
                self.removeAllChildren()
                break
            }
        }
    }
    
    // Pega a distância dos pontos
    func getDistance(n1_:[CGFloat], n2_:[CGFloat]) -> CGFloat {
        return CGFloat(sqrt(pow(n1_[0] - n2_[0], 2) + pow(n1_[1] - n2_[1], 2)))
    }
    
    // Define as posições quando muda de tela
    func setNewPosition(p_:Particle) {
        var pos = p_.getPositions()
        var x = (self.oldSize[0]*pos[0]) / self.size.width
        var y = (self.oldSize[1]*pos[1]) / self.size.height
        p_.setPositions(x, y)
    }
}
