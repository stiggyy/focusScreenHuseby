//
//  ViewController.swift
//  focusScreenHuseby
//
//  Created by CATHERINE HUSEBY on 3/6/24.
//

import UIKit

import FirebaseCore

import FirebaseDatabase
class Classroom{
    //var ref: DatabaseReference!
    
    var nameTeacher:String
    var classroomName:String
    var ref = Database.database().reference()
    var canFocus: Bool = false
    
    var code = 0
    var key = ""
    
    
    var Students = ["No students yet"]
    var studentPoints = [0]
    
    
    
    var store = [String]()
    
    var storePoints = [Int]()
    
    init(name: String, classname: String) {
        self.nameTeacher = name
        self.classroomName = classname
        self.makeCode()
        
    }
    
    init(dict: [String: Any]){
        
        if let a = dict["class"] as? String{
            self.classroomName = a
        } else {
            self.classroomName = "Class"
        }
        if let n = dict["teacher"] as? String{
            self.nameTeacher = n
        } else {
            self.nameTeacher = "John"
        }
        if let s = dict["students"] as? [String]{
            self.Students = s
        } else {
            self.Students = ["No Students Yet"]
        }
        if let b = dict["canFocus"] as? Bool{
            self.canFocus = b
        } else {
            self.canFocus = false
        }
        if let points = dict["points"] as? [Int]{
            self.studentPoints = points
        } else {
            self.studentPoints = [0]
        }
        
        if let storeList = dict["storeList"] as? [String]{
            self.store = storeList
        } else {
            self.store = ["Smile :)"]
        }
        if let sPoints = dict["sPoints"] as? [Int]{
            self.storePoints = sPoints
        } else{
            self.storePoints = [0]
        }
        if let code = dict["code"] as? Int {
            self.code = code
        } else {
            self.code = 00000
            
        }
    }
    func makeTrue(){
        canFocus = true
        
        ref.child("classroom").child(key).updateChildValues(["canFocus": canFocus])
    }
    
    func makeFalse(){
        canFocus = false
        
        ref.child("classroom").child(key).updateChildValues(["canFocus": canFocus])
    }

    
    func saveToFirebase(){
        //saving to dictionary
       //makeKey()
        let dict = ["teacher": nameTeacher, "class": classroomName, "students": Students, "canFocus": canFocus, "points": studentPoints, "storeList": store, "sPoints": storePoints, "code": code] as [String : Any]
        
        ref.child("classroom").childByAutoId().setValue(dict)
        
            // ref.child("classroom").
        
       // key = ref.child("classroom").childByAutoId().key ?? "0"
        
        print(key)
        
        //studs.append(self)
    }
    
    func deleteFromFirebase(){
            ref.child("classroom").child(key).removeValue()
        }
    
    func updateFirebase(dict: [String: Any]){
        ref.child("classroom").child(key).updateChildValues(dict)
    }
    
    func convertToDict() -> [String: Any]{
        let dict = ["teacher": nameTeacher, "class": classroomName, "students": Students, "canFocus": canFocus, "points": studentPoints, "storeList": store, "sPoints": storePoints, "code": code] as [String : Any]
        return dict
    }
    
    func checkNew(){
        ref.child("classroom").observe(.childChanged, with: { (snapshot) in
            let n = snapshot.value as! [String: Any]
            
            var stud = Classroom(dict: n)
            
            if self.key == stud.key{
                self.canFocus = stud.canFocus
            }
        })
    }

    func makeCode(){
        var newCode = Int.random(in: 1000...99999)
        for i in appData.classes {
            if i.code == newCode{
                newCode = Int.random(in: 1000...99999)
            }
        }
        
        self.code = newCode
        
    }
    
}

class appData{
    
    static var index = 0
    static var classes = [Classroom]()
    
    static var classSelected: Classroom!
    
    static var lockIn = false
    
    static var tOrS = "None"
    
    static var classHasSelected = false
}

class nameData: Codable{
    static let defaults = UserDefaults.standard
            

    static var name = ""
    
    static var tOrS = "None"
    
    static var nameIndex = 0

    
    
}

class ViewController: UIViewController {
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaults = UserDefaults.standard
        
      
        
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        
        ref.child("classroom").observe(.childChanged, with: { (snapshot) in
            let n = snapshot.value as! [String: Any]
            
            var stud = Classroom(dict: n)
            
            for x in 0...appData.classes.count-1{
                if appData.classes[x].key == stud.key{
                    appData.classes[x] = stud
                }
            }
        })
        
        ref.child("classroom").observe(.childAdded, with: { (snapshot) in
                  // snapshot is a dictionary with a key and a value
            
                // this gets each name from each snapshot
                let n = snapshot.value as! [String: Any]
                // adds the name to an array if the name is not already therep
                
                print(n)
                var stud = Classroom(dict: n)
                stud.key = snapshot.key
                
                appData.classes.append(stud)
            print(stud.nameTeacher)
                print(stud.key)
               // self.myTableView.reloadData()
                //                   if !self.names.contains(n){
                //                       self.names.append(n)
                //                   }
                
        
               } )
        
        ref.child("classroom").observe(.childRemoved, with: { (snapshot) in
            
          //  var x = 0
            for i in 0..<appData.classes.count{
                if appData.classes[i].key == snapshot.key {
                    //x = x + 1
                    appData.classes.remove(at: i)
                    break
                }
               // x = x + 1
            }
            
            //self.studs.remove(at: x)
          //  self.myTableView.reloadData()
            
            
        }
        )
        
        if let name = nameData.defaults.data(forKey: "name") {
                        let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(String.self, from: name) {
                nameData.name = decoded
                        }
            
                }
        
        
        if let tOrS = nameData.defaults.data(forKey: "tOrS") {
                        let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(String.self, from: tOrS) {
                nameData.tOrS = decoded
                        }
            
                }
        
        if let nameIndex = nameData.defaults.data(forKey: "nameIndex") {
                        let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Int.self, from: nameIndex) {
                nameData.nameIndex = decoded 
                        }
            
                }
    }
    
    @objc func appMovedToBackground() {
       print("did NOT lock in")
        
        if appData.classSelected.canFocus ?? false{
            appData.lockIn = false
            print("mission flopped")
        }
        
    }


}

