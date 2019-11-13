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
    
    var passwordIsValid = false
    var usernameIsValid = false
    var emailIsValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor.rgb(red: 95, green: 196, blue: 141, alpha: 0.8)
        
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
        err.backgroundColor = .systemGroupedBackground
        err.layer.cornerRadius = 5
        err.clipsToBounds = true
        err.font = .systemFont(ofSize: 14)
        err.numberOfLines = 2
        err.adjustsFontSizeToFitWidth = false
        err.alpha = 0
        return err
    }()
    
    let usernameErrorLabel: UILabel = {
        let err = UILabel()
        err.textAlignment = .center
        err.textColor = .red
        err.backgroundColor = .systemGroupedBackground
        err.layer.cornerRadius = 5
        err.clipsToBounds = true
        err.font = .systemFont(ofSize: 14)
        err.numberOfLines = 2
        err.adjustsFontSizeToFitWidth = false
        err.alpha = 0
        return err
    }()
    
    func showLabel(_ message: String, _ label: UILabel) {
        label.text = message
        label.alpha = 1
        
        view.addSubview(label)
        label.anchor(top: signUpInput.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 32, paddingRight: 32, width: 200, height: 40)
    }
    
    func hideLabel(_ label: UILabel) {
        label.removeFromSuperview()
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
                self.showLabel(errmsg, self.errorLabel)
            }
        }
        
         SVProgressHUD.dismiss()
        

        
    }
    
    func judgeValidity() {
        if emailIsValid && passwordIsValid && usernameIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 95, green: 196, blue: 141)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 95, green: 196, blue: 141, alpha: 0.8)
        }
    }
    
    @IBAction func emailValidity(_ sender: Any) {
        if emailTextfield.text!.count > 0 {
            emailIsValid = true
        } else {
            emailIsValid = false
        }
        
        judgeValidity()
        
    }
    

    @IBAction func passwordSecure(_ sender: Any) {
        if passwordTextfield.text!.count > 0 {
            if Utilities.isPasswordValid(passwordTextfield.text!) == false {
                //Password isn't secure enough
                let err = "密码需要至少8个字符，并且包含大小写字母和数字"
                showLabel(err, errorLabel)
                passwordIsValid = false
            } else {
                hideLabel(errorLabel)
                passwordIsValid = true
            }
        }
        judgeValidity()
    }
    
    @IBAction func usernameValidity(_ sender: Any) {
        if usernametextfield.text!.count > 0 {
//            print(usernametextfield.text!)
//            print(Utilities.isUsernameValid(usernametextfield.text!))
            if Utilities.isUsernameValid(usernametextfield.text!) == false {
                //username is illegal
                let err = "用户名需要4-14个字符，支持中英文、数字，不允许包含特殊字符和空格"
                showLabel(err, usernameErrorLabel)
                usernameIsValid = false
            } else {
                hideLabel(usernameErrorLabel)
                usernameIsValid = true
            }
        }
        judgeValidity()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
