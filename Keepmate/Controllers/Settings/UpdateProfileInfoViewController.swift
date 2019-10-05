//
//  UpdateProfileInfoViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/10/1.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit

class UpdateProfileInfoViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var done: UIButton!
    @IBOutlet var barTitle: UINavigationBar!
    @IBOutlet weak var changeProfilePic: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet var updateProfileInfo: UITableView!
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let firstArray = ["昵称", "性别"]
    let secondArray = ["生日", "所在城市"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return firstArray.count
        } else if section == 1 {
            return secondArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UpdateProfileInfoTableViewCell = .init(style: .value1, reuseIdentifier: "updateProfileInfoCell")
        
        
        let user = BmobUser.current()
        let query: BmobQuery = BmobUser.query()
        
        if indexPath.section == 0 {
            cell.textLabel?.text = firstArray[indexPath.row]
            if firstArray[indexPath.row] == "昵称" {
                let editUsername = UITextField(frame: CGRect(x: 1, y: 1, width: 100, height: 20))
                editUsername.placeholder = user?.username
                editUsername.clearButtonMode = .whileEditing
                editUsername.textAlignment = .right
                cell.accessoryView = editUsername
            } else {
                query.getObjectInBackground(withId: user?.objectId) { (obj, error) in
                    if error != nil {
                        cell.detailTextLabel?.text = "请选择性别"
                        cell.detailTextLabel?.textColor = .gray
                    } else {
                        if obj != nil {
                            let gender = obj?.object(forKey: "gender") as? String
                            cell.detailTextLabel?.text = gender
                            cell.detailTextLabel?.textColor = .gray
                        }
                    }
                }
                
            }
        } else if indexPath.section == 1 {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = self.secondArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // UIView with darkGray background for section-separators as Section Header
        let v = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 35))
        v.backgroundColor = .systemBackground
        return v
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeProfilePic.clipsToBounds = true
        changeProfilePic.layer.cornerRadius = changeProfilePic.bounds.height / 2
        
        updateProfileInfo.delegate = self
        updateProfileInfo.dataSource = self
        updateProfileInfo.tableFooterView = UIView()
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
