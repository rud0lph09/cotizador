//
//  4ViewController.swift
//  Allianz
//
//  Created by Rodolfo Castillo on 12/20/16.
//  Copyright © 2016 Mariachis. All rights reserved.
//

import UIKit

class fourthViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectedText: UITextField!
    
    var pickerInput: UIPickerView!
    
    var dataPayload: [[String]] = [[], ["mˆ2"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerInput = UIPickerView()
        self.pickerInput.delegate = self
        self.pickerInput.dataSource = self
        self.pickerInput.selectRow(0, inComponent: 1, animated: false)
        
        
        for i in 1...10000{
            self.dataPayload[0].append("\(i)")
        }
        self.selectButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
    }
    
    func showOptions(){
        var alert = UIAlertController(title: "¿Cuántos metros cuadrados mide tu hogar?", message: "\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.actionSheet);
        alert.isModalInPopover = true;
        
        //  Create a frame (placeholder/wrapper) for the picker and then create the picker
        let pickerFrame: CGRect = CGRect(x: 17, y: 52, width: 270, height: 200); // CGRectMake(left), top, width, height) - left and top are like margins
        self.pickerInput.frame = pickerFrame
        //  Add the picker to the alert controller
        alert.view.addSubview(pickerInput)
        
        self.pickerInput.center.x = alert.view.frame.width / 2
        
        let action = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        
        //Do stuff and action on appropriate object.
        self.present(alert, animated: true, completion: nil)
    }
    



    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataPayload.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataPayload[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(dataPayload[component][row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.selectedText.text = "\(self.dataPayload[0][row]) \(self.dataPayload[1][0])"
        
        
        
        
    }
}
