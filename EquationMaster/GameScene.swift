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
    
    @objc func spawnEqation() {
        let newEquation = Equation()
        self.equations.append(newEquation)
        
        let label = SKLabelNode(text: newEquation.label)
        label.position = CGPoint(
            x: Double.random(in: 1...Double(frame.height)),
            y: Double.random(in: (label.frame.width)...Double(frame.width - label.frame.width))
        )
        label.name = String(describing: newEquation.correctResult)
        label.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 20))
        label.physicsBody?.affectedByGravity = true
        label.physicsBody?.isDynamic = true
        label.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -10))
        scene?.addChild(label)
    }
}
