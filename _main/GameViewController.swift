/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
// Globais
import SpriteKit

// Locais
import class Modules.GameScene

/**
    # Configurações da cena
    Configurações do que acontece na tela e como reagir às ações que ocorrem ao longo do programa.
    ## Atributos
    
    |     Atributos     |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | scene             | Funcionalidades do jogo e da cena.                |
    |-------------------|---------------------------------------------------|
    
    ## Métodos
    
    |      Métodos      |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | viewDidMove       | Configurações de quando a cena é carregada.       |
    | touchesBegan      | Ação de quando clica na tela.                     |
    | touchesMoved      | Ação de quando arrasta na tela.                   |
    | touchesEnded      | Ação de quando para de clicar na tela.            |
    |-------------------|---------------------------------------------------|
*/
public class GameViewController: UIViewController {
    // Atributos da classe
    private let scene = GameScene()
    
    /**
        # Método [lifecycle]:
        Toda vez que a tela é carregada (inicializada) essas configuraçôes serão feitas.
    */
    public override func viewDidLoad() {
        super.viewDidLoad()                                 // Chama a função original
        let view = SKView()                                 // Cria uma view
        scene.scaleMode = .resizeFill                       // Adapta a cena pra tela mostrada
        view.presentScene(scene)                            // Mostra a cena criada
        // view.showsFPS = true                                // Mostra o fps
        // view.showsNodeCount = true                          // Mostra a quantidade de nodes que tem
        self.view = view                                    // Define a cena
    }
    
    
    /**
        # Método:
        Ação de quando clica na tela.
    */
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: scene)        // Pega a localização atual do click
            
            let touchesNodes = scene.nodes(at: location)    // Pega os nodes que foram clicados
            for n in touchesNodes {
                scene.startDrag([location.x, location.y])   // Manda a localização pra cena
            }
        }
    }
    
    
    /**
        # Método:
        Ação de quando arrasta algo na tela.
    */
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: scene)        // Pega a localização
            scene.drag([location.x, location.y])            // Manda a localização pra cena
        }
    }
    
    /**
        # Método:
        Ação de quando para de clicar na tela.
    */
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene.drop()
    }
}
