//
//  LoginViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/9/14.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func gotoRegister(_ sender: UIButton) {
        let sb = UIStoryboard(name:"LoginAndRegister",bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "Register")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let tabViewController = main.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
