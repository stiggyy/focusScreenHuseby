//
//  ViewControllerSettings.swift
//  focusScreenHuseby
//
//  Created by CATHERINE HUSEBY on 3/19/24.
//

import UIKit

class ViewControllerSettings: UIViewController {

    @IBOutlet weak var nameOutlet: UILabel!
    
    
    @IBOutlet weak var roleOutlet: UILabel!
    
    @IBOutlet weak var pointsOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameOutlet.text = "Name: \(nameData.name)"
        
        roleOutlet.text = "Role: \(nameData.tOrS)"
        
        
        
        if nameData.tOrS == "Teacher" {
            pointsOutlet.text = "No Points: You are the teacher"
        }

        // Do any additional setup after loading the view.
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
