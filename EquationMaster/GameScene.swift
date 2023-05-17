//
//  GameScene.swift
//  EquationMaster
//
//  Created by Štěpán Pazderka on 12.05.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var userLabel = SKLabelNode(text: "")
    
    var equations = [Equation]()
    var deletionTimer: Timer?
    var generateEquationTimer: Timer?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.generateEquationTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(spawnEqation), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        scene?.physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.1)
        
        
        scene?.addChild(userLabel)
        userLabel.name = "UserInput"
        userLabel.position.x = frame.midX
        userLabel.position.y = frame.midY
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func mouseDown(with event: NSEvent) {
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
    }
    
    override func keyDown(with event: NSEvent) {
        self.deletionTimer?.invalidate()
        
        let isBackspace = event.keyCode == 51
        let isReturn = event.keyCode == 36
        
        if isBackspace || isReturn {
            self.userLabel.text?.removeAll()
        }
        
        if let character = event.characters {
            self.userLabel.text?.append(character)
        }
        
        for equation in equations {
            if String(describing: equation.correctResult) == userLabel.text {
                self.equations.removeAll { $0 == equation }
                
                self.enumerateChildNodes(withName: String(describing: equation.correctResult)) { node, pointer in
                    node.removeFromParent()
                    
                    self.explodeEquation(label: node)
                }
                DispatchQueue.global().async {
                    sleep(1)
                    self.userLabel.text?.removeAll()
                }
            }
        }
        self.deletionTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(deleteWhatUserTyped), userInfo: nil, repeats: false)
    }
    
    @objc func deleteWhatUserTyped() {
        self.userLabel.text?.removeAll()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let nodes = scene?.children else { return }
        for node in nodes {
            if node.position.y < -100 {
                node.removeFromParent()
            }
        }
    }
    
    @objc func spawnEqation() {
        let newEquation = Equation()
        self.equations.append(newEquation)
        
        let label = SKLabelNode(text: newEquation.label)
        let lowerBound = label.frame.width
        let upperBound = Double(frame.width) - label.frame.width
        label.position = CGPoint(
            x: Double.random(in: lowerBound..<upperBound),
            y: frame.height
        )
        label.name = String(describing: newEquation.correctResult)
        label.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 20))
        label.physicsBody?.affectedByGravity = true
        label.physicsBody?.isDynamic = true
        label.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -10))
        scene?.addChild(label)
    }
    
    func explodeEquation(label: SKNode) {
        if let explosionEffect = SKEmitterNode(fileNamed: "ExplosionParticle") {
            explosionEffect.position = label.position
            
            let texture = view?.texture(from: label)
            
            if let texture {
                explosionEffect.particleTexture = texture
            }
            
            addChild(explosionEffect)
            let removeAction = SKAction.sequence([SKAction.wait(forDuration: 2.0), SKAction.removeFromParent()])
            explosionEffect.run(removeAction)
        }
    }
}
