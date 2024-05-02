//
//  ViewControllerFocussed.swift
//  focusScreenHuseby
//
//  Created by CATHERINE HUSEBY on 3/11/24.
//

import UIKit
import FirebaseCore

import FirebaseDatabase

class ViewControllerFocussed: UIViewController {
    var ref: DatabaseReference!
    var alertController: UIAlertController!
    
    @IBOutlet weak var classNameOutlet: UILabel!
    
    @IBOutlet weak var classCodeOut: UILabel!
    
    @IBOutlet weak var canFocusLabel: UILabel!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        classCodeOut.text = "Code: \(appData.classSelected.code)"
        
        ref = Database.database().reference()
        
        
        ref.child("classroom").observe(.childChanged, with: { (snapshot) in
            let n = snapshot.value as! [String: Any]
            
            var stud = Classroom(dict: n)
            stud.key = snapshot.key
            if appData.classSelected.key == stud.key{
                appData.classSelected = stud
                
            }
            
            print(appData.classSelected.canFocus)
        })


        
        
        
        alertController = UIAlertController(title: "You're now in focus mode", message: "Dont leave the app in order to earn points", preferredStyle: .alert)
       

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        var a = 0
        for x in appData.classSelected.Students{
            if x == nameData.name{
                nameData.nameIndex = a
            }
            
            a = a + 1
        }
        
        
        
        classNameOutlet.text = "Class name: \(appData.classSelected.classroomName)"
        canFocusLabel.text = "Points: \(appData.classSelected.studentPoints[nameData.nameIndex])"
        
        
        if nameData.tOrS == "Teacher" {
            canFocusLabel.text = "You are the teacher: click the button to begin class check in"
        }
    }
    @IBAction func focusAction(_ sender: Any) {
        
        var a = 0
        for x in appData.classSelected.Students{
            if x == nameData.name{
                nameData.nameIndex = a
            }
            
            a = a + 1
        }
        
        var abc = false
        //print(appData.classSelected.classroomName)
        //print(appData.classSelected)
        if nameData.name == appData.classSelected.nameTeacher {
            appData.classSelected.makeTrue()
            alertController.message = "Click the button to end focus"
            let endAction = UIAlertAction(title: "End Focus", style: .default) { (action) in
                // handle response here.
                appData.classSelected.makeFalse()
                //appData.classSelected.canFocus = false
                
                //appData.classSelected.saveToFirebase()
                
                
                
            }
            alertController.addAction(endAction)
            
            present(alertController, animated: true)
            
            
            
            
        } else {
            if appData.classSelected.canFocus {
                
                abc = true
               // print("we focusing")
                appData.lockIn = true
                
    
            } else {
                alertController.message = "Your teacher has not yet started focus"
                let endAction = UIAlertAction(title: "Whoops", style: .default) { (action) in
                    // handle response here.
                   
                    
                    
                }
                alertController.addAction(endAction)
                
                present(alertController, animated: true)
            }
        }
        
        
        
        
        
        
        if abc {
            alertController.message = "Click the button to end student focus"
            let endAction = UIAlertAction(title: "End Student Focus", style: .default) { (action) in
                appData.lockIn = false
                print("mission flopped")
                self.defaults.set(appData.lockIn, forKey: "theLock")
                if abc{
                    let alert = UIAlertController(title:  "", message: "End of Focus", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                
              //  appData.classSelected.checkNew()
            
                // handle response here.
                print(appData.classSelected.canFocus)
                
                if appData.classSelected.canFocus == false{
                    print("you earned points")
                    
                    appData.classSelected.studentPoints[nameData.nameIndex] = appData.classSelected.studentPoints[nameData.nameIndex] + 10
                    
                    appData.classSelected.updateFirebase(dict: appData.classSelected.convertToDict())
                    
                    
                }
                //appData.classSelected.canFocus = false
                
                
                
            }
            
            alertController.addAction(endAction)
            
            present(alertController, animated: true)
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

}
