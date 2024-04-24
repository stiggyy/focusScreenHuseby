//
//  ViewControllerJoin.swift
//  focusScreenHuseby
//
//  Created by CATHERINE HUSEBY on 3/7/24.
//

import UIKit

class ViewControllerJoin: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameOutlet: UITextField!
    
    @IBOutlet weak var codeOutlet: UITextField!
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertController = UIAlertController(title: "Class joined", message: "YAY", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "EPIC", style: .default) { (action) in
            // handle response here.
            
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)

        // Do any additional setup after loading the view.
        
        nameOutlet.delegate = self
        codeOutlet.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameOutlet.text = "\(nameData.name)"
    }
    
    @IBAction func joinAction(_ sender: Any) {
        let name = nameOutlet.text ?? ""
        let code = Int(codeOutlet.text!) ?? 00000
        var joined = "No class joined,"
        for x in 0...appData.classes.count-1 {
            if appData.classes[x].code == code{
                appData.classes[x].Students.append(name)
                appData.classes[x].studentPoints.append(0)
                //appData.classes[x].saveToFirebase()
                appData.classes[x].updateFirebase(dict: appData.classes[x].convertToDict())
                
                joined = "Class joined"
                
                
                for y in 0...appData.classes[x].Students.count-1{
                    if appData.classes[x].Students[y] == name {
                        nameData.nameIndex = y
                    }
                }
            }
            
            
        
            
        
        }
        
        
        alertController.message = "\(joined) Class code = \(code)"
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
        
        nameData.name = name
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(nameData.name) {
                        nameData.defaults.set(encoded, forKey: "name")
                    }
        
        
        nameData.tOrS = "Student"
        
        //let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(nameData.tOrS) {
                        nameData.defaults.set(encoded, forKey: "tOrS")
                    }
        
        if let encoded = try? encoder.encode(nameData.tOrS) {
                        nameData.defaults.set(encoded, forKey: "nameIndex")
                    }
        


        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           nameOutlet.resignFirstResponder()
           codeOutlet.resignFirstResponder()
           
           return true
       }
}
