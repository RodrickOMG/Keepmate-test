//
//  ProfileScrollView.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/7/17.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BmobEventDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
     }
     */
    
//    func save(){
//        let gamescore:BmobObject = BmobObject(className: "GameScore")
//        gamescore.setObject("Jhon Smith", forKey: "playerName")
//        gamescore.setObject(90, forKey: "score")
//        gamescore.saveInBackground { (isSuccessful, error) in
//            if error != nil{
//                print("error is \(error?.localizedDescription ?? "nil")")
//            }else{
//                print("success")
//            }
//        }
//    }
    func getCurrentUser() {
        let user = BmobUser.current()
        print(user!.username ?? "Not Logged In")
        nameLabel.text = user!.username ?? "Not Logged In"
        emailLabel.text = user!.email ?? ""
    }
    

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        view.backgroundColor = UIColor.white
        
        let screenFrame = UIScreen.main.bounds
        let screenWidth = screenFrame.size.width
        let screenHeight = screenFrame.size.height
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        scroll.bounces = true
        scroll.isDirectionalLockEnabled = false //default false
        scroll.isPagingEnabled = false
        
        scroll.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        //add additional scroll area around content
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scroll.showsVerticalScrollIndicator = true
        scroll.indicatorStyle = .black
        scroll.bouncesZoom = true
        //如果正显示着键盘，拖动，则键盘撤回
        scroll.keyboardDismissMode = .onDrag
        scroll.flashScrollIndicators()
        
        scroll.delegate = self
        
        scroll.addSubview(containerView)
        containerView.anchor(top: scroll.topAnchor, left: scroll.leftAnchor, paddingTop: 0, paddingLeft: 0, width: UIScreen.main.bounds.width, height: 220 )
        
        return scroll
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        
        view.addSubview(profilePicButton)
        profilePicButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePicButton.anchor(top: view.topAnchor, paddingTop: 20,
                                width: 110, height: 110)
        profilePicButton.layer.cornerRadius = 110 / 2
        
        view.addSubview(messageButton)
        messageButton.anchor(top: view.topAnchor, left: view.leftAnchor,
                             paddingTop: 20, paddingLeft: 32, width: 32, height: 32)
        
        view.addSubview(followButton)
        followButton.anchor(top: view.topAnchor, right: view.rightAnchor,
                            paddingTop: 20, paddingRight: 32, width: 32, height: 32)
        
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profilePicButton.bottomAnchor, paddingTop: 12)
        
        view.addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
        
        return view
    }()
    
    let profilePicButton: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "default_profile_pic"), for: .normal)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.imageView?.contentMode = .scaleAspectFill
        iv.imageView?.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        iv.isUserInteractionEnabled = true
        iv.addTarget(self, action: #selector(handleProfilePicture), for: .touchUpInside)
        return iv
    }()
    
    let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_mail_outline_white_2x").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMessageUser), for: .touchUpInside)
        return button
    }()
    
    let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_person_add_white_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleFollowUser), for: .touchUpInside)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Eddie Brock"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "venom@gmail.com"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentUser()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        //save()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Selectors
    
    @objc func handleMessageUser() {
        print("Message user here..")
    }
    
    @objc func handleFollowUser() {
        print("Follow user here..")
    }
    
    @objc func handleProfilePicture() {
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
            profilePicButton.setImage(originalImage, for: .normal)
        } else if let editImage = info[.editedImage] as? UIImage{
            profilePicButton.setImage(editImage, for: .normal)
        }
        
        dismiss(animated: true, completion: { self.uploadProfilePic() })
    }
    
    
    func uploadProfilePic() {
        guard let image = self.profilePicButton.imageView?.image else { return }
        guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
        
        //Home目录
        let homeDirectory = NSHomeDirectory()
        let documentPath = homeDirectory + "/Documents"
        //文件管理器
        let fileManager: FileManager = FileManager.default
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        do {
            try fileManager.createDirectory(atPath: documentPath, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error {

        }
        fileManager.createFile(atPath: documentPath.appendingFormat("/image.png"), contents: uploadData, attributes: nil)
        //得到选择后沙盒中图片的完整路径
        let filePath: String = String(format: "%@%@", documentPath, "/image.png")
        print("filePath:" + filePath)
        
        let user = BmobUser.current()
        let file = BmobFile.init(filePath: filePath)
        
        
        file?.save(inBackground: { [weak file] (isSuccessful, error) in
            if isSuccessful {
                let weakFile = file
                print("Successfully upload file")
                user!.setObject(weakFile, forKey: "profilePic")
                user!.setObject("helloworld", forKey: "profilePicName")
                user!.updateInBackground { (isSuccessful, error) in
                    if error != nil {
                        print("save ", error as Any)
                    }
                }
            } else {
                print("upload ", error as Any)
            }
        }, withProgressBlock: { (process) in
            print("process:  ", process)
        })
        
    }

}
