//
//  ViewController.swift
//  EquationMaster
//
//  Created by Štěpán Pazderka on 12.05.2023.
//

import Cocoa
import SpriteKit
import GameplayKit

protocol GameMasterDelegate {
    func startNewGame()
}

class ViewController: NSViewController, GameMasterDelegate {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    func startNewGame() {
        guard let view = self.skView else { return }
        
        let gameScene = GameScene(size: view.frame.size)
        gameScene.gameMasterDelegate = self
        view.presentScene(gameScene)
    }
}

