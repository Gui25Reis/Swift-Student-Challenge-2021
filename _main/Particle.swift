/* Gui Reis     -    gui.sreis25@gmail.com */

// Bibliotecas necessárias:
import class SpriteKit.SKShapeNode
import class SpriteKit.SKAction
import struct SpriteKit.CGFloat
import SpriteKit

public class Particle {
    // Atributos da classe:
    private var node:SKShapeNode = SKShapeNode(circleOfRadius: 20)  // Bolinha
    private var radius:CGFloat = 20                           // Tamanho da bolinha
    private var initialTime:Int = 0                           // Quando foi criada
    private var lifeTime:Int = 0                              // Quanto tempo já durou
    private var specialNode:Bool = false                      // Verifica se é verde
    private var alive:Bool = true                             // Verifica se esta viva
    private var scale:CGFloat = 0.5                           // Proporção da bolinha
    
    // Construtor: Tira a borda, coloca a cor e define a escala
    init() {
        self.node.lineWidth = 0
        self.node.fillColor = #colorLiteral(red: 0.921, green: 0.250, blue: 0.145, alpha: 1.0)
        self.node.setScale(self.scale)
    }
    // Destrutor: Elimina (limpa) os atributos
    deinit {
        self.node.delete(nil)
        self.radius = 0
        self.initialTime = 0
        self.lifeTime = 0
        self.specialNode = false
        self.alive = false
        self.scale = 0
    }
    
    // Método especial: Retorna a bolinha
    public func getNode() -> SKShapeNode {return self.node}
    
    // Método especial: Define as posições
    public func setPositions(_ x_:CGFloat, _ y_:CGFloat) -> Void {
        self.node.position.x = x_
        self.node.position.y = y_
    }
    
    // Método especial: Retorna as posições
    public func getPositions() -> [CGFloat] {return [self.node.position.x, self.node.position.y]}
    
    // Método especial: Define o tipo da bolinha
    public func setSpecialNode(_ b_:Bool) -> Void {
        self.specialNode = b_
        self.setScale(1)
    }
    
    // Método especial: Retorna as posições
    public func isSpecialNode() -> Bool {return self.specialNode}
    
    // Método especial: Define a cor da bolinha perseguida
    public func setUserColor() -> Void {
        self.node.fillColor = #colorLiteral(red: 0.145, green: 0.643, blue: 0.921, alpha: 1.0)
        self.setSpecialNode(true)
    }
    
    // Método especial: Define a cor da bolinha perseguida
    public func setSpecialColor() -> Void {
        self.node.fillColor = #colorLiteral(red: 0.141, green: 0.862, blue: 0.341, alpha: 1.0)
        self.setSpecialNode(true)
    }
    
    // Método especial: Define a ação/posição das bolinhas
    public func setRun(_ act_:SKAction) -> Void {self.node.run(act_)}
    
    // Método especial: Retorna o raio
    public func getRadius() -> CGFloat {return self.radius}
    
    // Método especial: Retorna o tempo inicial
    public func getInitialTime() -> Int {return self.initialTime}
    
    // Método especial: Define o tempo inicial
    public func setInitialTime(_ t_:Int) -> Void {
        self.initialTime = t_
        self.setLifeTime(t_)
    }
    
    // Método especial: Define o tempo de vida
    public func setLifeTime(_ t_:Int) -> Void {self.lifeTime += t_}
    
    // Método especial: Retorna o tempo de vida
    public func getLifeTime() -> Int {return self.lifeTime}
    
    // Método especial: Mostra se já pode movimentar
    public func isReady() -> Bool {
        if (self.getLifeTime() > self.getInitialTime()+1) {
            return true
        }; return false
    }
    
    // Método especial: Define se esta viva
    public func setAlive(_ b_:Bool) -> Void {self.alive = b_}
    
    // Método especial: Retorna se esta viva
    public func isAlive() -> Bool {return self.alive}
    
    // Método especial: Define a escala e o alpha
    public func setScale(_ s_:CGFloat) -> Void {
        self.scale = s_
        self.node.setScale(self.scale)
        self.node.alpha = self.scale
    }
    
    // Método especial: Retorna a escala
    public func getScale() -> CGFloat {return self.scale}
}
