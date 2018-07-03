//
//  SideBarVC.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/20/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
class SideBarVC: UITableViewController {
    var handle: AuthStateDidChangeListenerHandle?
    var db: Firestore!
    var userArray = [UserModel]()
    @IBOutlet weak var userNameLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            print(user)
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                
                let uid = user.uid
                let email = user.email
                // self.userEmailLBL.text = email
                
                
                
            }
            
        })
        
        self.userNameLBL.text = UserDefaults.standard.string(forKey: "Username")
//        self.db.collection("users").getDocuments(completion: { (querysnapshot, error) in
//            if let error = error{
//                print("\(error.localizedDescription)")
//            }else{
//                self.userArray = querysnapshot!.documents.flatMap({UserModel(dictionary: $0.data())})
//                var userItem: UserModel = self.userArray[0] as UserModel
//                self.userNameLBL.text = userItem.username
//            }
//        })
        
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
}
