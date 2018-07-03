//
//  ViewController.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/19/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var UserNotFoundLBL: UILabel!
    var isSignIn = true
    var userArray = [UserModel]()
    var db: Firestore!
    
    
    
    
    
    
    
    
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
        })
        loadUsername()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignInSelectorAction(_ sender: UISegmentedControl) {
        //Flip the value
        isSignIn = !isSignIn
        //check action and update labels
        if isSignIn {
            signInBtn.setTitle("Sign In", for: .normal)
        }else{
            self.UserNotFoundLBL.isHidden = true
            signInBtn.setTitle("Register", for: .normal)
        }
    }
    
    
    @IBAction func SignInAction(_ sender: UIButton) {
        print("IS SIGN IN  \(isSignIn)")
        if isSignIn{
            //Do TF validation
            //Sign in user with firebase
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
                if let u = user{
                    //user found, go to home screen
                    print("User Signed In")
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }else{
                    //Error:
                    self.UserNotFoundLBL.isHidden = false
                    print("ERROR 1")
                }
            }
        }else{
            //Register user with firebase
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
                if let u = user{
                    //user found, go to home screen
                    print("User Registed")
                }else{
                    //Error:
                    print("ERROR 2")
                    print(error!)
                }
            }
        }
    }
}

extension ViewController{
    
    func loadUsername(){
        self.db.collection("users").getDocuments(completion: { (querysnapshot, error) in
            if let error = error{
                print("\(error.localizedDescription)")
            }else{
                self.userArray = querysnapshot!.documents.flatMap({UserModel(dictionary: $0.data())})
                print(self.userArray)
                print(self.userArray[0])
                var userItem: UserModel = self.userArray[0] as UserModel
                print("USERNAME: \(userItem.username)")
                UserDefaults.standard.set(userItem.username, forKey: "Username")
            }
        })
    }
    
}

