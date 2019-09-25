//
//  RegisterViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/9/13.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var usernametextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signUpInput: UIStackView!
    

    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.isEnabled = false
        
        self.hideKeyboard()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let errorLabel: UILabel = {
        let err = UILabel()
        err.textAlignment = .center
        err.textColor = .red
        err.font = UIFont(name: "Roboto", size: 11.0)
        err.numberOfLines = 2
        err.adjustsFontSizeToFitWidth = true
        err.alpha = 0
        return err
    }()
    
    func showLabel(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        
        view.addSubview(errorLabel)
        errorLabel.anchor(top: signUpInput.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 32, paddingRight: 32, width: 200, height: 40)
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //TODO: Set up a new user on our Bmob database
        SVProgressHUD.show()
        
        let user = BmobUser()
        
        guard let email = emailTextfield.text, email.count>0  else { return }
        guard let username = usernametextfield.text, username.count>0 else { return }
        guard let password = passwordTextfield.text, password.count>0  else { return }
        
        user.email = email
        user.username = username
        user.password = password
        
        user.signUpInBackground {
            (isSuccessful, error) in if isSuccessful {
                print("Successfullly created user: " + username)
                UserDefaults.standard.set(true, forKey: "everLaunched")
                SVProgressHUD.dismiss()
                let sb = UIStoryboard(name:"Main",bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "MainTable")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                let errmsg = "Failed to create user. " + error!.localizedDescription
                self.showLabel(errmsg)
            }
        }
        
         SVProgressHUD.dismiss()
        

        
    }
    
    
    @IBAction func handleTextInputChange(_ sender: Any) {
        
        let isFormValid = emailTextfield.text?.count ?? 0 > 0 && passwordTextfield.text?.count ?? 0 > 0 && usernametextfield.text?.count ?? 0 > 0
        
        print(isFormValid)
        
        
        if isFormValid{
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 255, green: 125, blue: 38)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 255, green: 160, blue: 38)
        }
    }

    @IBAction func passwordSecure(_ sender: Any) {
        if passwordTextfield.text!.count > 0 {
            if Utilities.isPasswordValid(passwordTextfield.text!) == false {
                //Password isn't secure enough
                let err = "Password must be at least 8 characters, and contain at least one upper case letter, one lower case letter, and one number."
                showLabel(err)
            } else {
                let blankLabel = ""
                showLabel(blankLabel)
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
