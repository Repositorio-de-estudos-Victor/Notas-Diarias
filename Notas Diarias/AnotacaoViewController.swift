//
//  AnotacaoViewController.swift
//  Notas Diarias
//
//  Created by Victor Rodrigues Novais on 09/05/20.
//  Copyright © 2020 Victoriano. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configurações iniciais
        self.texto.becomeFirstResponder()
        
        if anotacao != nil { // Atualizar
            self.texto.text = anotacao.value(forKey: "texto") as? String
        } else { // Criar
            self.texto.text = ""
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    @IBAction func salvar(_ sender: Any) {
        if anotacao != nil { // Atualizar
            self.atualizarAnotacao()
        } else { // Salvar
            self.salvarAnotacao()
        }
        
        
        //Retorna para a tela principal
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func salvarAnotacao() {
        
        // Cria objeto para anotação
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        // Configura anotação
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao salvar anotação!")
        } catch let erro{
            print("Erro ao salvar anotação: \(erro.localizedDescription)" )
        }
    }
    
    func atualizarAnotacao() {
        
        // Configura anotação
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar anotação!")
        } catch let erro{
            print("Erro ao atualizar anotação: \(erro.localizedDescription)" )
        }
    }

}
