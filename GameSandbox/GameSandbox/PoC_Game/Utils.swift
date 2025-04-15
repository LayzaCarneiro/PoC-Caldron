//
//  Utils.swift
//  GameSandbox
//
//  Created by Layza Maria Rodrigues Carneiro on 15/04/25.
//

import SwiftUI
import SpriteKit

struct Ingrediente: Identifiable, Hashable {
    let id = UUID()
    let nome: String
    let atributos: [String: Int]
}

struct Pedido: Identifiable, Hashable {
    let id = UUID()
    let nome: String
    let atributosDesejados: [String: Int]
}

enum Caldeirao: String, CaseIterable, Identifiable {
    case prata = "Prata"
    case cobre = "Cobre"
    
    var id: String { self.rawValue }
}

let ingredientes: [Ingrediente] = [
    Ingrediente(nome: "star", atributos: ["AFE": 1, "CH": 1]),
    Ingrediente(nome: "circle", atributos: ["MEM": 2, "PRE": -1]),
    Ingrediente(nome: "square", atributos: ["SAÚ": 2, "AFE": -1]),
    Ingrediente(nome: "heart", atributos: ["SEN": 2, "COR": -2]),
    Ingrediente(nome: "triangle", atributos: ["COR": 1, "MEM": -1])
]

let pedidos: [Pedido] = [
    Pedido(nome: "Problema 01 - Antonio", atributosDesejados: ["MEM": 2, "AFE": 1]),
    Pedido(nome: "Problema 02 - Claudia", atributosDesejados: ["SEN": 2, "SAÚ": 2]),
    Pedido(nome: "Problema 01 - Maria", atributosDesejados: ["MEM": -2, "COR": 2]),
    Pedido(nome: "Problema 02 - Silvio", atributosDesejados: ["MEM": 1, "AFE": 1]),
    Pedido(nome: "Problema 03 - Roberta", atributosDesejados: ["PRE": -1, "AFE": 1])
]

func calcularCompatibilidade(
    nomeIngrediente1: String = "star",
    nomeIngrediente2: String = "circle",
    pedido: Pedido = Pedido(nome: "Problema 01 - Antonio", atributosDesejados: ["MEM": 2, "AFE": 1]),
    caldeirao: Caldeirao = .prata
) -> Double {
    guard let ingrediente1 = buscarIngredientePorNome(nome: nomeIngrediente1),
          let ingrediente2 = buscarIngredientePorNome(nome: nomeIngrediente2) else {
        return 0.0
    }

    var soma: [String: Int] = [:]
    
    let atributos1 = caldeirao == .cobre
    ? ingrediente1.atributos.mapValues { -$0 }
    : ingrediente1.atributos
    
    let atributos2 = caldeirao == .cobre
    ? ingrediente2.atributos.mapValues { -$0 }
    : ingrediente2.atributos
    
    for (key, value) in atributos1 {
        soma[key, default: 0] += value
    }
    
    for (key, value) in atributos2 {
        soma[key, default: 0] += value
    }
    
    var somasIndividuais: [Double] = []
    
    for (atributo, desejado) in pedido.atributosDesejados {
        let obtido = soma[atributo, default: 0]
        
        if (desejado >= 0 && obtido >= desejado) || (desejado < 0 && obtido <= desejado) {
            somasIndividuais.append(1.0)
        } else {
            let diff = abs(Double(obtido - desejado))
            let compat = max(0, 1.0 - (diff / Double(abs(desejado))))
            somasIndividuais.append(compat)
        }
    }
    
    let media = somasIndividuais.reduce(0, +) / Double(somasIndividuais.count)
    return media * 100
}

func buscarIngredientePorNome(nome: String) -> Ingrediente? {
    return ingredientes.first { $0.nome == nome }
}

func ingredientName(from texture: SKTexture?) -> String {
    guard let name = texture?.description else { return "unknown" }

    if name.contains("circle") { return "circle" }
    if name.contains("star") { return "star" }
    if name.contains("square") { return "square" }
    if name.contains("heart") { return "heart" }
    return "unknown"
}
