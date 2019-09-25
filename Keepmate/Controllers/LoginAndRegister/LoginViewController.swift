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
                print(error!.localizedDescription)
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
        
        
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error: Error?) in
//            
//            if let err = error{
//                print("Failed to sign in, reason: ", err)
//            } else {
//                print("Successfully sign in: ", user?.user.email ?? "")
//                UserDefaults.standard.set(true, forKey: "everLaunched")
//                let sb = UIStoryboard(name:"Main",bundle: Bundle.main)
//                let vc = sb.instantiateViewController(withIdentifier: "MainTable")
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
//            }
//        }
        
        SVProgressHUD.dismiss()
        
//        BmobUser.loginWithUsername(inBackground: usernameTextfield.text!, password: passwordTextfield.text!)
//        { (user, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            } else {
//                print("Login successfully")
//                UserDefaults.standard.set(true, forKey: "everLaunched")
//                SVProgressHUD.dismiss()
//                let main = UIStoryboard(name: "Main", bundle: nil)
//                let tabViewController = main.instantiateInitialViewController()
//                UIApplication.shared.keyWindow?.rootViewController = tabViewController
//            }
    
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
