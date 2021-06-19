//
//  MemoriaViewController.swift
//  JogoDaMemoria
//
//  Created by Renan Carvalho de Oliveira Fernandes on 09/06/21.
//

import UIKit

class MemoriaViewController: UIViewController {
    
    var jogoDaMemoria: JogoDaMemoria = JogoDaMemoria.aleatorio()
    var parPecasAtual: [UIButton] = []
    var acao: UIAlertAction {
        .init(title: "Bacana, bora de novo", style: .default) { _ in
            self.recarrega()
        }
    }
    
    
    @IBOutlet var pecas: [UIButton]!
    
    @IBAction func toqueReiniciar(_ sender: Any) {
        recarrega()
    }
    
    @IBAction func toque(_ sender: UIButton) {
        atualiza()
        
        guard let indice = pecas.firstIndex(of: sender) else { return }
             
        let figura = jogoDaMemoria.jogar(posicaoNaMesa: indice)
        
        parPecasAtual.append(sender)
        
        vira(sender: sender, figura: figura)
        
        if jogoDaMemoria.estado == .vitoria {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.notificarVitoria()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func atualiza() {
        switch jogoDaMemoria.estado {
        case .diferentes:
            desvira(pecasPraDesvirar: parPecasAtual)
        case .iguais:
            parPecasAtual.removeAll()
            break
        default:
            break
        }
    }
    
    private func vira(sender: UIButton, figura: String) {
        let nomeImagem = "card-\(figura)"
        let imagem = UIImage(named: nomeImagem)
        
        UIView.transition(with: sender, duration: 0.5, options: .transitionCrossDissolve) {
            sender.setBackgroundImage(imagem, for: UIControl.State.normal)
        }
        
        sender.isUserInteractionEnabled = false
    }
    
    func desvira(pecasPraDesvirar: [UIButton]) {
        for peca in pecasPraDesvirar {
            let imagem = UIImage(named: "card")
            
            UIView.transition(with: peca, duration: 0.5, options: .transitionCrossDissolve) {
                peca.setBackgroundImage(imagem, for: UIControl.State.normal)
            }

            peca.isUserInteractionEnabled = true
        }
    }
    
    private func notificarVitoria() {
        let alerta = UIAlertController(title: "Boa, você terminou!", message: "Você precisou de \(jogoDaMemoria.tentativas) tentativas para finalizar o jogo da memória.", preferredStyle: .alert)
        
        alerta.addAction(
            acao
        )
        
        present(alerta, animated: true)
    }
        
    func recarrega() {
        desvira(pecasPraDesvirar: pecas)
        
        parPecasAtual.removeAll()
        jogoDaMemoria = JogoDaMemoria.aleatorio()
    }
}

