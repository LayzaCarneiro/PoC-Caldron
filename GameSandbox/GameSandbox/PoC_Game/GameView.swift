//
//  GameView.swift
//  HelloSpriteKit
//
//  Created by Layza Maria Rodrigues Carneiro on 15/04/25.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @State private var pedidoSelecionado: Pedido?
    @State private var compatibilidade: Double = 0

    var body: some View {
        VStack {
            Picker("Escolha o Pedido", selection: $pedidoSelecionado) {
                ForEach(pedidos) { pedido in
                    Text(pedido.nome)
                        .tag(pedido as Pedido?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Text("Compatibilidade: \(String(format: "%.1f", compatibilidade))%")
                            .font(.headline)
            
            GeometryReader { proxy in
                SpriteView(scene: scene(size: proxy.size, pedidoSelecionado: pedidoSelecionado))
                    .id(pedidoSelecionado?.id)
            }
            .statusBar(hidden: true)
        }
    }
    
    func scene(size: CGSize, pedidoSelecionado: Pedido?) -> SKScene {
        let scene = GameScene()
        scene.size = size
        scene.pedido = pedidoSelecionado
        
        scene.onCompatibilidadeCalculada = { resultado in
            DispatchQueue.main.async {
                self.compatibilidade = resultado
            }
        }

        return scene
    }
}
