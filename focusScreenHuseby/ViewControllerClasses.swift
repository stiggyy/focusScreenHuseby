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
        
        //listOfClasses.removeAll()
        //tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
        
        //tableView.reloadData()
        
        
            //  print("god save us all")
    }
    
    //viewdid
    
    override func viewWillAppear(_ animated: Bool) {
        
        listOfClasses.removeAll()
        //tableView.
        //tableView.reloadData()
        
       // print(appData.classes.count)
        for x in 0..<appData.classes.count{
            for a in 0..<appData.classes[x].Students.count{
                
                if appData.classes[x].Students[a] == nameData.name {
                    
                    listOfClasses.append(appData.classes[x])
                        // break
                }
            }
        }
        
        
        for x in 0..<appData.classes.count{
                
            if appData.classes[x].nameTeacher == nameData.name {
                    
                    listOfClasses.append(appData.classes[x])
               // break
                print(appData.classes[x])
                }
            
        }
        
        
       
        
       // print(listOfClasses)
        
        
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfClasses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel!.text = "\(listOfClasses[indexPath.row].classroomName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toClass", sender: self)
        appData.classSelected = listOfClasses[indexPath.row]
        appData.classHasSelected = true
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
