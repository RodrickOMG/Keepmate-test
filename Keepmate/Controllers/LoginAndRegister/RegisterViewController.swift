//
//  RegisterViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/9/13.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //TODO: Set up a new user on our Bmob database
        SVProgressHUD.show()
        let user = BmobUser()
        user.username = usernameTextfield.text!
        
        user.password = passwordTextfield.text!
        user.signUpInBackground {
            (isSuccessful, error) in if isSuccessful {
                print("Register successfully")
                UserDefaults.standard.set(true, forKey: "everLaunched")
                SVProgressHUD.dismiss()
                let main = UIStoryboard(name: "Main", bundle: nil)
                let tabViewController = main.instantiateInitialViewController()
                UIApplication.shared.keyWindow?.rootViewController = tabViewController
            } else {
                print("Register failed, reason:\(error!.localizedDescription)")
            }
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
