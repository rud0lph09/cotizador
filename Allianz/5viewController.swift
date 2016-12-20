//
//  5viewController.swift
//  Allianz
//
//  Created by Rodolfo Castillo on 12/20/16.
//  Copyright © 2016 Mariachis. All rights reserved.
//

import UIKit



class CotizadorController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func callToFinish(){
        let alert = UIAlertController(title: "Listo!", message: "Hemos terminado el proceso. Ahora puedes escoger una llamada telefónica para el pago del servicio o escoge la opción de SMS para recibir una notificación cuando tu servicio se haya activado. \n\n\n\n\n\n", preferredStyle: .alert)
        let photoView = UIImageView(frame: CGRect(x: 95, y: 140, width: 60, height: 60))
        photoView.image = UIImage(named: "ok")
        alert.view.addSubview(photoView)
        let smsAction = UIAlertAction(title: "SMS", style: .default, handler: { (action) in
            self.getEvents("https://examplerimac.herokuapp.com/error", completion: { (completed) in
                
            })
        })
        let callAction = UIAlertAction(title: "Llamar Ahora", style: .cancel, handler: { (action) in
            self.schemeAvailable(scheme: "tel:53363277")
            /*tel:1-408-555-5555*/
        })
        alert.addAction(smsAction)
        alert.addAction(callAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func schemeAvailable(scheme: String) -> Bool {
        if let url = URL(string: scheme) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func getEvents(_ daUrl: String, completion: @escaping (_ finished: Bool)-> ()){
        let URL = Foundation.URL(string: daUrl)!
        var request = URLRequest(url:URL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
            } else {
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                    print(jsonObject)
                    completion(true)
                    
                }catch {
                    print("Error Json: \(error)")
                }
            }
        })
        task.resume()
    }
    
    
}

extension CotizadorController {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "priceCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callToFinish()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = CGSize(width: self.view.frame.width - 70, height: self.collection.frame.height - 100)
        return size
    }
    
    
}
