//
//  ViewController.swift
//  EquationMaster
//
//  Created by Štěpán Pazderka on 12.05.2023.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = self.skView else { return }
        
        let gameScene = GameScene(size: view.frame.size)
        view.presentScene(gameScene)
    }
}

