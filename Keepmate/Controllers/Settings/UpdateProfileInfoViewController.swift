//
//  UpdateProfileInfoViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/10/1.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit

class UpdateProfileInfoViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var done: UIButton!
    @IBOutlet var barTitle: UINavigationBar!
    @IBOutlet weak var changeProfilePic: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeProfilePic.clipsToBounds = true
        changeProfilePic.layer.cornerRadius = changeProfilePic.bounds.height / 2
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func handleChangeProfilePic(_ sender: UIButton) {
        //setup profile picture or change it
        let actionSheet = UIAlertController(title: "上传头像", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        
        let takePhotos = UIAlertAction(title: "拍照", style: .destructive, handler: {
            (action: UIAlertAction) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
                
            }
            else
            {
                print("模拟其中无法打开照相机,请在真机中使用");
            }
            
        })
        let selectPhotos = UIAlertAction(title: "相册选取", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            profilePic.image = originalImage
            profilePic.contentMode = .scaleAspectFill
//            profilePic.setImage(originalImage, for: .normal)
        } else if let editImage = info[.editedImage] as? UIImage{
            profilePic.image = editImage
            profilePic.contentMode = .scaleAspectFill
//            profilePic.setImage(editImage, for: .normal)
        }
        dismiss(animated: true, completion: nil)
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
