//
//  JogoDaMemoriaTests.swift
//  JogoDaMemoriaTests
//
//  Created by Renan Carvalho de Oliveira Fernandes on 09/06/21.
//

import XCTest
@testable import JogoDaMemoria

class JogoDaMemoriaTests: XCTestCase {
    
    var jogoDaMemoria: JogoDaMemoria!
    
    override func setUp() {
        jogoDaMemoria = JogoDaMemoria.aleatorio()
    }
    
    func test_jogandoUmaVez_naoDeveIncrementarTentativas() {
        let _ = jogoDaMemoria.jogar(posicaoNaMesa: 0)
        
        XCTAssertEqual(jogoDaMemoria.tentativas, 0)
    }
    
    func test_jogandoDuasVez_deveIncrementarTentativas() {
        let _ = jogoDaMemoria.jogar(posicaoNaMesa: 0)
        let _ = jogoDaMemoria.jogar(posicaoNaMesa: 1)
        
        XCTAssertEqual(jogoDaMemoria.tentativas, 1)
    }
    
    func test_jogandoUmaVez_naoDeveIncrementarParesCorretos() {
        let _ = jogoDaMemoria.jogar(posicaoNaMesa: 1)
        
        XCTAssertEqual(jogoDaMemoria.paresCorretos, 0)
    }
    
    func test_jogandoUmaVez_deveEstarNoEstadoParcial() {
        let _ = jogoDaMemoria.jogar(posicaoNaMesa: 1)
        
        XCTAssertEqual(jogoDaMemoria.estado, .parcial)
    }
    
    func test_mesa_deveConterDezPecas() {
        XCTAssertEqual(jogoDaMemoria.mesa.count, 10)
    }
    
    func test_acertandoUmaPeca_deveIncrementarParesCorretos() {
        var i = 1
        while jogoDaMemoria.estado != .iguais {
            let _ = jogoDaMemoria.jogar(posicaoNaMesa: 0)
            let _ = jogoDaMemoria.jogar(posicaoNaMesa: i)
            
            i += 1
        }
        
        XCTAssertEqual(jogoDaMemoria.paresCorretos, 1)
    }
    
    func test_aposUmAcertoProximaJogada_deveFazerJogoVoltarParaEstadoParcial() {
        var i = 1
        while jogoDaMemoria.estado != .iguais {
            let _ = jogoDaMemoria.jogar(posicaoNaMesa: 0)
            let _ = jogoDaMemoria.jogar(posicaoNaMesa: i)
            
            i += 1
        }
        
        let _ = jogoDaMemoria.jogar(posicaoNaMesa: 0)
        
        XCTAssertEqual(jogoDaMemoria.estado, .parcial)
    }
    
    func test_aposAcertarTodasPecas_deveEstarNoEstadoVitoriaComNumeroDeParesCorretos() {
        for i in 0...9 {
            for j in 1...9 {
                guard i != j else { return }
                let _ = jogoDaMemoria.jogar(posicaoNaMesa: i)
                let _ = jogoDaMemoria.jogar(posicaoNaMesa: j)
            }
        }
        
        XCTAssertEqual(jogoDaMemoria.estado, .vitoria)
        XCTAssertEqual(jogoDaMemoria.mesa.count, jogoDaMemoria.paresCorretos * 2)
    }
}
