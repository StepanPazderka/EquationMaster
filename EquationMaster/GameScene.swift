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
    
    var equations: [Equation]
    var deletionTimer: Timer?

    override init(size: CGSize) {
        func generateEquations(count: Int) -> [Equation] {
            var equationArray = [Equation]()
            for _ in 1...count {
                equationArray.append(Equation())
            }
            return equationArray
        }
        
        self.equations = generateEquations(count: 10)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sceneDidLoad() {

    }
    
    override func didMove(to view: SKView) {
        for equation in equations {
            let label = SKLabelNode(text: equation.label)
            label.position = CGPoint(
                x: Double.random(in: 1...Double(frame.height)),
                y: Double.random(in: 1...Double(frame.width - label.frame.height * 2)))
            label.name = String(describing: equation.correctResult)
            label.physicsBody = SKPhysicsBody()
            label.physicsBody?.affectedByGravity = false
            label.physicsBody?.isDynamic = true
            label.physicsBody?.applyImpulse(CGVector(dx: 10000, dy: 0))
            scene?.addChild(label)
            
        }
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

        if let character = event.characters {
            self.userLabel.text?.append(character)
        }
                
        for equation in equations {
            if String(describing: equation.correctResult) == userLabel.text {
                self.equations.removeAll { $0 == equation }
                
                self.enumerateChildNodes(withName: String(describing: equation.correctResult)) { node, pointer in
                    node.removeFromParent()
                }
                
                self.userLabel.text?.removeAll()
            }
        }
        self.deletionTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(deleteWhatUserTyped), userInfo: nil, repeats: false)
    }
    
    @objc func deleteWhatUserTyped() {
        self.userLabel.text?.removeAll()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func startSpawningWords(interval: TimeInterval) {
        
    }
}
