//
//  3aViewController.swift
//  Allianz
//
//  Created by Rodolfo Castillo on 12/20/16.
//  Copyright © 2016 Mariachis. All rights reserved.
//

import UIKit

class thirdAViewController: UIViewController {
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectedText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
    }
    
    func showOptions(){
        let alert = UIAlertController(title: "Selecciona una opción", message: "Valor aproximado de tus bienes,", preferredStyle: .actionSheet)
        let option1 = UIAlertAction(title: "1 Millon", style: .default, handler: {(action)in
            self.selectedText.text = "1 Millon"
            
        })
        let option2 = UIAlertAction(title: "2 Millones", style: .default, handler: {(action)in
            self.selectedText.text = "2 Millones"
            
        })
        let option3 = UIAlertAction(title: "3 Millones", style: .default, handler: {(action)in
            self.selectedText.text = "3 Millones"
            
        })
        alert.addAction(option1)
        alert.addAction(option2)
        alert.addAction(option3)
        self.present(alert, animated: true, completion: nil)
    }

    
}
