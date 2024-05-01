//
//  ViewControllerCreate.swift
//  focusScreenHuseby
//
//  Created by CATHERINE HUSEBY on 3/7/24.
//

import UIKit

class ViewControllerCreate: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var classNameOutlet: UITextField!
    
    @IBOutlet weak var nameOutlet: UITextField!
    
    var code = 0000
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController = UIAlertController(title: "Class created", message: "Class code: \(code)", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "EPIC", style: .default) { (action) in
            // handle response here.
            
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)

        // Do any additional setup after loading the view.
        
        classNameOutlet.delegate = self
        nameOutlet.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        nameOutlet.text = "\(nameData.name)"
    }
    @IBAction func createClassAction(_ sender: Any) {
      
        
        let name = nameOutlet.text ?? ""
        let classname = classNameOutlet.text ?? ""
        
        if appData.tOrS == "Teacher" || appData.tOrS == "None"{
            var newClass = Classroom(name: name, classname: classname)
            
            newClass.saveToFirebase()
            //print(newClass.key)
            code = newClass.code
            
            nameData.name = name
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(nameData.name) {
                nameData.defaults.set(encoded, forKey: "name")
            }
            alertController.message = "Class code = \(code)"
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
            
            
            nameData.tOrS = "Teacher"
            
            //let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(nameData.tOrS) {
                nameData.defaults.set(encoded, forKey: "tOrS")
            }
        }
        else {
            alertController.title = "Error"
            alertController.message = "Students Cannot Create a Class."
            present(alertController, animated: true){
                
            }
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
           classNameOutlet.resignFirstResponder()
           nameOutlet.resignFirstResponder()
           
           return true
       }

}
