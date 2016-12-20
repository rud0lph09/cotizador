//
//  1ViewController.swift
//  Allianz
//
//  Created by Rodolfo Castillo on 12/20/16.
//  Copyright © 2016 Mariachis. All rights reserved.
//

import UIKit

class firstViewController: UIViewController {
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectedText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
    }
    
    func showOptions(){
        let alert = UIAlertController(title: "Selecciona una opción", message: "Eres Dueño, inquilino o arrendatario", preferredStyle: .actionSheet)
        let option1 = UIAlertAction(title: "Dueño", style: .default, handler: {(action)in
            self.selectedText.text = "Dueño"
        
        })
        let option2 = UIAlertAction(title: "Arrendatario", style: .default, handler: {(action)in
            self.selectedText.text = "Arrendatario"
            
        })
        let option3 = UIAlertAction(title: "Inquilino", style: .default, handler: {(action)in
            self.selectedText.text = "Inquilino"
            
        })
        alert.addAction(option1)
        alert.addAction(option2)
        alert.addAction(option3)
        self.present(alert, animated: true, completion: nil)
    }
    
}
