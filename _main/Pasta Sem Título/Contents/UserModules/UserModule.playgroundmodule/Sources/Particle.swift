import  SpriteKit

public class Particle {
    // Atributos da classe:
    private var node:SKShapeNode = SKShapeNode(circleOfRadius: 20)  // Bolinha
    private var radius:CGFloat = 20                                 // Tamanho da bolinha
    private let color:UIColor = #colorLiteral(red: 0.3997545242, green: 0.6133489013, blue: 0.2060141265, alpha: 1.0)                                  // Cor da bolinha
    private var initialTime:Int = 0                                 // Quando foi cirada
    private var lifeTime:Int = 0                                    // QUanto tempo já durou
    
    // Construtor: tira a borda e coloca a cor da bolinha
    init() {
        node.lineWidth = 0
        node.fillColor = self.color
    }
    // Desstrutor: elimina(limpa) os atributos
    deinit{
        self.node.delete(nil)
        self.radius = 0
        self.initialTime = 0
        self.lifeTime = 0
    }
    
    // Método especial: retorna a bolinha
    public func getNode() -> SKShapeNode {
        return self.node
    }
    
    // Método especial: define as posições
    public func setPositions(_ x_:CGFloat, _ y_:CGFloat) {
        self.node.position.x = x_
        self.node.position.y = y_
    }
    
    // Método especial: retorna as posições
    public func getPositions() -> [CGFloat] {
        return [self.node.position.x, self.node.position.y]
    }
    
    // Método especial: Define a cor da bolinha perseguida
    public func setUserColor() {
        node.fillColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    // Método especial: Define a cor da bolinha perseguida
    public func setSpecialColor() {
        node.fillColor = #colorLiteral(red: 0.8267027736, green: 0.3405264616, blue: 0.9946629405, alpha: 1.0)
    }
    
    // Método especial: Define a ação/posição das bolinhas
    public func setRun(_ act_:SKAction) {
        node.run(act_)
    }
    
    // Método especial: Retorna o raio
    public func getRadius() -> CGFloat {
        return self.radius
    }
    
    // Método especial: Retorna o tempo inicial
    public func getInitialTime() -> Int {
        return self.initialTime
    }
    
    // Método especial: Define o tempo de vida
    public func setLifeTime(t_:Int){
        self.lifeTime = t_
    }
    
    // Método especial: Retorna o tempo de vida
    public func getLifeTime() -> Int {
        return self.lifeTime
    }
}
