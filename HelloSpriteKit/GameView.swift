//
//  GameView.swift
//  HelloSpriteKit
//
//  Created by Layza Maria Rodrigues Carneiro on 15/04/25.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    var body: some View {
        GeometryReader { proxy in
            SpriteView(scene: scene(size: proxy.size))
        }
        .statusBar(hidden: true)
    }
    
    func scene(size: CGSize) -> SKScene {
        let scene = GameScene()
        scene.size = size
        return scene
    }
}
