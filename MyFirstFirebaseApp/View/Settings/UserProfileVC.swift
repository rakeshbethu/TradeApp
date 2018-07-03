//
//  UserProfileVC.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/20/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserProfileVc: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?
    var db: Firestore!
    var UID = ""
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                self.emailTF.text = email
                self.UID = uid
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func UpdateProfileAction(_ sender: UIButton) {
        // Add a new user document with a generated ID
   //    db.collection("test").document("first").setData([  "name":"rakesh"])
        db.collection("users").document("\(UID as! String)").setData([
            "name":"\(emailTF.text as! String)",
            "UID":"\(UID as! String)",
            "email":"\(emailTF.text as! String)",
            "first": "\(fnameTF.text as! String)",
            "last": "\(lnameTF.text as! String)",
            "username": "\(usernameTF.text as! String)",
            "phone":"\(phoneNumTF.text as! String)"
            
            ])
        
    }
    
    
    
    
}
