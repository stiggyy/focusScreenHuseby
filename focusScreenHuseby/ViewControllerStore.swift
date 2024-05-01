//
//  ViewControllerStore.swift
//  focusScreenHuseby
//
//  Created by CATHERINE HUSEBY on 3/19/24.
//

import UIKit
//help

class ViewControllerStore: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var alertController: UIAlertController!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appData.classHasSelected{
            return appData.classSelected.store.count ?? 0
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "\(appData.classSelected.store[indexPath.row]), \(appData.classSelected.storePoints[indexPath.row]) points"
        return cell
    }
    
    
    @IBOutlet weak var classSelectedLabel: UILabel!
    
    @IBOutlet weak var addItemButtonOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var xyz: UILabel!
    
    @IBOutlet weak var nameOutlet: UITextField!
    
    
    @IBOutlet weak var pointsoutlet: UITextField!
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if appData.classHasSelected{
            if nameData.tOrS == "Student"{
                xyz.text = "\(appData.classSelected.studentPoints[nameData.nameIndex]), \(appData.classSelected.classroomName)"
               
                
            } else {
                xyz.text = "You are the teacher"
                
               
            }
            classSelectedLabel.text = "\(appData.classSelected.classroomName)"
        } else {
            classSelectedLabel.text = "Go to classes and select a class"
        }
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if nameData.tOrS == "Student" {
            addItemButtonOutlet.isHidden = true
        }
        if nameData.tOrS == "Teacher" {
            addItemButtonOutlet.isHidden = false        }
        else {
            addItemButtonOutlet.isHidden = true
        }
        
        if appData.classHasSelected{
            if nameData.tOrS == "Student"{
                xyz.text = "\(appData.classSelected.studentPoints[nameData.nameIndex]), \(appData.classSelected.classroomName)"
               
                
            } else {
                xyz.text = "You are the teacher"
                
               
            }
            classSelectedLabel.text = "\(appData.classSelected.classroomName)"
        } else {
            classSelectedLabel.text = "Go to classes and select a class"
        }
        
        
        
        tableView.reloadData()
    }
    

    @IBAction func addStoreItem(_ sender: Any) {
        let name = nameOutlet.text ?? ""
        
        let p = Int(pointsoutlet.text ?? "") ?? 0
        
        if nameData.tOrS == "Teacher"{
            appData.classSelected.store.append(name)
            appData.classSelected.storePoints.append(p)
            appData.classSelected.updateFirebase(dict: appData.classSelected.convertToDict())
        }
        
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if nameData.tOrS == "Student"{
            alertController = UIAlertController(title: "Bought \(appData.classSelected.store[indexPath.row]) for \(appData.classSelected.storePoints[indexPath.row]) points", message: "Click confirm to close out", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                // handle response here.
                appData.classSelected.studentPoints[nameData.nameIndex] = appData.classSelected.studentPoints[nameData.nameIndex] - appData.classSelected.storePoints[nameData.nameIndex]
                
                appData.classSelected.updateFirebase(dict: appData.classSelected.convertToDict())
                self.xyz.text = "points : \(appData.classSelected.studentPoints[nameData.nameIndex])"
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
                self.xyz.text = "points : \(appData.classSelected.studentPoints[nameData.nameIndex])"
            }
            
            xyz.text = "points : \(appData.classSelected.studentPoints[nameData.nameIndex])"
            
        }
        else if nameData.tOrS == "Teacher"{
            alertController = UIAlertController(title: "Delete \(appData.classSelected.store[indexPath.row]), \(appData.classSelected.storePoints[indexPath.row]) points?", message: "Click confirm to delete", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                // handle response here.
                appData.classSelected.store.remove(at: indexPath.row)
                appData.classSelected.storePoints.remove(at: indexPath.row)
                appData.classSelected.updateFirebase(dict: appData.classSelected.convertToDict())
                tableView.reloadData()
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
                //self.xyz.text = "points : \(appData.classSelected.studentPoints[nameData.nameIndex])"
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

}
