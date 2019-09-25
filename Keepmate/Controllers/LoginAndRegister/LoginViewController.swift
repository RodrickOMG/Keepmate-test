//
//  LoginViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/9/14.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var signInInput: UIStackView!
    
    @IBAction func gotoRegister(_ sender: UIButton) {
        let sb = UIStoryboard(name:"LoginAndRegister",bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "Register")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        guard let email = emailTextfield.text, email.count>0  else { return }
        guard let password = passwordTextfield.text, password.count>0  else { return }
        
        BmobUser.loginInbackground(withAccount: email, andPassword: password) { (user, error) in
            if error != nil {
                let errmsg = "Failed to sign in. " + error!.localizedDescription
                self.showLabel(errmsg)
            } else {
                print("Login successfully")
                UserDefaults.standard.set(true, forKey: "everLaunched")
                SVProgressHUD.dismiss()
                let sb = UIStoryboard(name:"Main",bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "MainTable")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        
        SVProgressHUD.dismiss()
        
    
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
        errorLabel.anchor(top: signInInput.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 32, paddingRight: 32, width: 200, height: 40)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        
        self.hideKeyboard()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleTextInputChange(_ sender: Any) {
        let isFormValid = emailTextfield.text?.count ?? 0 > 0 && passwordTextfield.text?.count ?? 0 > 0
        if isFormValid{
            loginButton.backgroundColor = UIColor.rgb(red: 255, green: 125, blue: 38)
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = UIColor.rgb(red: 255, green: 160, blue: 38)
            loginButton.isEnabled = false
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
