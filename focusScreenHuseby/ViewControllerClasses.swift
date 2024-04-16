//
//  ViewControllerClasses.swift
//  focusScreenHuseby
//
//  Created by CATHERINE HUSEBY on 3/8/24.
//

import UIKit
import FirebaseCore

import FirebaseDatabase

class ViewControllerClasses: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var ref: DatabaseReference!
    @IBOutlet weak var tableView: UITableView!
    var listOfClasses = [Classroom]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        listOfClasses.removeAll()
        tableView.reloadData()
        ref = Database.database().reference()
        
        
        ref.child("classroom").observe(.childChanged, with: { (snapshot) in
            let n = snapshot.value as! [String: Any]
            
            var stud = Classroom(dict: n)
            
            for x in 0...appData.classes.count-1{
                if appData.classes[x].key == stud.key{
                    appData.classes[x] = stud
                }
            }
            
            self.tableView.reloadData()
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
            self.tableView.reloadData()
        
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
            self.tableView.reloadData()
            
        }
        )
        listOfClasses.removeAll()
        print(appData.classes.count)
        for x in 0...appData.classes.count-1{
            for a in 0...appData.classes[x].Students.count-1{
                
                if appData.classes[x].Students[a] == nameData.name {
                    
                    listOfClasses.append(appData.classes[x])
                }
            }
        }
        
        
        for x in 0...appData.classes.count-1{
                
            if appData.classes[x].nameTeacher == nameData.name {
                    
                    listOfClasses.append(appData.classes[x])
                }
            
        }
        
        
        print(listOfClasses)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfClasses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = "\(listOfClasses[indexPath.row].classroomName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toClass", sender: self)
        appData.classSelected = listOfClasses[indexPath.row]
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
