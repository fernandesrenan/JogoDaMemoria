//
//  JogoDaMemoria.swift
//  JogoDaMemoria
//
//  Created by Renan Carvalho de Oliveira Fernandes on 10/06/21.
//

import Foundation

class JogoDaMemoria {
    let mesa: [String]
        
    var tentativas = 0
    var paresCorretos = 0 {
        didSet {
            if paresCorretos == mesa.count / 2 {
                estado = .vitoria
            }
        }
    }
    
    private(set) var estado: Estado = .parcial
    private var parAtual: (primeira: String?, segunda: String?) = (nil, nil) {
        didSet {
            if parAtual.segunda == nil {
                estado = .parcial
            } else if parAtual.primeira == parAtual.segunda {
                estado = .iguais
                paresCorretos += 1
            } else {
                estado = .diferentes
            }
        }
    }
    
    init(mesa: [String]) {
        self.mesa = mesa
    }
    
    func jogar(posicaoNaMesa: Int) -> String {
        let figura = mesa[posicaoNaMesa]
        
        if parAtual.primeira == nil {
            parAtual.primeira = figura
        } else if parAtual.segunda == nil {
            parAtual.segunda = figura
            tentativas += 1
        } else {
            parAtual = (figura, nil)
        }
        
        return figura
    }
}

extension JogoDaMemoria {
    enum Estado: Int {
        case iguais = 1
        case parcial = 2
        case diferentes = 3
        case vitoria = 4
    }
}

extension JogoDaMemoria {
    class func aleatorio() -> JogoDaMemoria {
        let mesa = Array([cartas, cartas].joined()).shuffled()
        
        return JogoDaMemoria(mesa: mesa)
    }
}

private let cartas = [
    "anao",
    "elfa",
    "bruxa",
    "mago",
    "cavaleiro"
]
