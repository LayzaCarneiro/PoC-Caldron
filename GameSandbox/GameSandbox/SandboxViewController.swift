import UIKit
import SpriteKit

class SandboxViewController: UIViewController {
            
    let scene: SKScene
    
    let skView = SKView()
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupSKView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    private func setupSKView() {
        view.addSubview(skView)
        skView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            skView.leftAnchor.constraint(equalTo: view.leftAnchor),
            skView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
    }

}


