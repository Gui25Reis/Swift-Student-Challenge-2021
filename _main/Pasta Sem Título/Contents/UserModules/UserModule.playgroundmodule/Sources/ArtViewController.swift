import SpriteKit

public class ArtViewController: UIViewController {
    public override func viewDidLoad() {
        // didLoad: Carrega a cena
        super.viewDidLoad()
        
        let view = SKView()
        let scene = ArtScene()
        
        // Adapta a cena pra tela mostrada
        scene.scaleMode = .resizeFill
        
        // Mostra a cena criada
        view.presentScene(scene)
        
        self.view = view
    }
}
