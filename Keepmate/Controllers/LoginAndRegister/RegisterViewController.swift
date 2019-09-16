//
//  RegisterViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/9/13.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //TODO: Set up a new user on our Bmob database
        SVProgressHUD.show()
        
        guard let email = emailTextfield.text, email.count>0  else { return }
        guard let password = passwordTextfield.text, password.count>0  else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error: Error?) in
            if let err = error{
                print("Failed to create user, reason: ", err)
                return
            } else {
                print("Successfullly created user: ", user?.user.uid ?? "")
                UserDefaults.standard.set(true, forKey: "everLaunched")
                let main = UIStoryboard(name: "Main", bundle: nil)
                let tabViewController = main.instantiateInitialViewController()
                UIApplication.shared.keyWindow?.rootViewController = tabViewController
            }
            
        }
        
        
         SVProgressHUD.dismiss()
        
//        user.signUpInBackground {
//            (isSuccessful, error) in if isSuccessful {
//                print("Register successfully")
//                UserDefaults.standard.set(true, forKey: "everLaunched")
//                SVProgressHUD.dismiss()
//                let main = UIStoryboard(name: "Main", bundle: nil)
//                let tabViewController = main.instantiateInitialViewController()
//                UIApplication.shared.keyWindow?.rootViewController = tabViewController
//            } else {
//                print("Register failed, reason:\(error!.localizedDescription)")
//            }
//        }
        
    }
    @IBAction func handleTextInputChange(_ sender: Any) {
        
        let isFormValid = emailTextfield.text?.count ?? 0 > 0 && passwordTextfield.text?.count ?? 0 > 0
        print(isFormValid)
        if isFormValid{
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 255, green: 125, blue: 38)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 255, green: 160, blue: 38)
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
