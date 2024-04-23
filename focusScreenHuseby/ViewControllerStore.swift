//
//  ViewControllerStore.swift
//  focusScreenHuseby
//
//  Created by CATHERINE HUSEBY on 3/19/24.
//

import UIKit
//help

class ViewControllerStore: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.classSelected.store.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "\(appData.classSelected.store[indexPath.row]), \(appData.classSelected.storePoints[indexPath.row])"
        return cell
    }
    
    @IBOutlet weak var addItemButtonOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var xyz: UILabel!
    
    @IBOutlet weak var nameOutlet: UITextField!
    
    
    @IBOutlet weak var pointsoutlet: UITextField!
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if nameData.tOrS == "Student"{
            xyz.text = "\(appData.classSelected.studentPoints[nameData.nameIndex]), \(appData.classSelected.classroomName)"
            
            
        } else {
            xyz.text = "You are the teacher"
            
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    

    @IBAction func addStoreItem(_ sender: Any) {
        let name = nameOutlet.text ?? ""
        
        let p = Int(pointsoutlet.text ?? "") ?? 0
        
        if nameData.tOrS == "Teacher"{
            appData.classSelected.store.append(name)
            appData.classSelected.storePoints.append(p)
            appData.classSelected.updateFirebase(dict: appData.classSelected.convertToDict())
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
