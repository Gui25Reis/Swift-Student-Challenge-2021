/* Gui Reis     -    gui.sreis25@gmail.com */

import SpriteKit

import class Modules.GameScene

public class GameViewController: UIViewController {
    let scene = GameScene()
    
    // didLoad: Carrega a cena
    public override func viewDidLoad() {
        super.viewDidLoad()
        let view = SKView()
        scene.scaleMode = .resizeFill     // Adapta a cena pra tela mostrada
        view.presentScene(scene)          // Mostra a cena criada
        // view.showsFPS = true              // Mostra o fps
        // view.showsNodeCount = true        // Mostra a quantidade de nodes que tem
        self.view = view                  // Define a cena
        
    }
    
    // Quando clica
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: scene)     // Pega a localização
            
            let touchesNodes = scene.nodes(at: location) // Pega os nodes que foram clicados
            for n in touchesNodes {
                scene.startDrag([location.x, location.y]) // Manda as posições de moviemento
            }
        }
    }
    
    // Move com o click pressionado
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: scene)    // Pega a localização
            scene.drag([location.x, location.y])        // Envia pra função
        }
    }
    
    // Deixa de clicar
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene.drop()
    }
}
    

