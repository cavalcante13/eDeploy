//
//  PontuationListViewController.swift
//  TesteEdeploy
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import UIKit

class PontuationListViewController: UIViewController {

    @IBOutlet weak var pontuationLabel: UILabel?
    
    var address : Address!
    
    init(address : Address) {
        self.address = address
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.pontuationListViewController.resultado()
        loadPontuation()
    }
    
    final private func loadPontuation() {
        AppStyle.startActivityIndicator()
        
        let params : [String : Any] = ["Nome" : address.city!, "Estado" : address.state!]
        
        let service : RestableService<Pontuation> = RestableService(path: R.string.endPoint.buscarPontos(), params: params)
        service.post(parse: Pontuation.init, callback: loadPontuationClosure())
    }
    
    final private func loadPontuationClosure()-> (Any)-> () {
        return { [weak self] pontuation in
            if let context = self {
                if let pontuation = pontuation as? Double {
                    context.setupPontuationLabel(value: pontuation)
                }else if let error = pontuation as? Error {
                    context.confirmAlert(title: "Erro", description: error.localizedDescription)
                }
                AppStyle.stopActivityIndicator()
            }
        }
    }
    
    final private func setupPontuationLabel(value : Double) {
        pontuationLabel?.text = R.string.pontuationListViewController.aPontuaçãoDaCidadeÉ(address.city!, value.decimal())
    }
}
