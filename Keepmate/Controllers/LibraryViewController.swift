//
//  LibraryView.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/8/6.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UIScrollViewDelegate
,UICollectionViewDelegate, UICollectionViewDataSource {
    
    let numberOfItems = 4
    var tagOfButtons = 0
    var scroll:UIScrollView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"itemId", for: indexPath)
        
        cell.backgroundColor = UIColor.red
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
        btn.backgroundColor = UIColor.gray
        
        switch tagOfButtons {
        case 0:
            btn.setBackgroundImage(UIImage(named: "pushupButtonBkg"), for: UIControl.State())
            btn.tag = 1
        case 1:
            btn.setBackgroundImage(UIImage(named: "situpButtonBkg"), for: UIControl.State())
            btn.tag = 2
        case 2:
            btn.setBackgroundImage(UIImage(named: "plankButtonBkg"), for: UIControl.State())
            btn.tag = 3
        case 3:
            btn.setBackgroundImage(UIImage(named: "Squat"), for: UIControl.State())
            btn.tag = 4
        default:
            print("Error")
        }
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        cell.addSubview(btn)
        
        tagOfButtons += 1
        return cell
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
        
        scroll.addSubview(theDayWorkoutLabel)
        theDayWorkoutLabel.anchor(top: scroll.topAnchor, left: scroll.leftAnchor, paddingTop: 5, paddingLeft: 30, width: screenWidth, height: 30)
        
        scroll.addSubview(theDayWorkoutButton)
        theDayWorkoutButton.anchor(top: theDayWorkoutLabel.bottomAnchor, left: scroll.leftAnchor, right: scroll.rightAnchor, paddingTop: 5, paddingLeft: 30, paddingRight: 30, width: screenWidth - 60, height: 220)
        
        scroll.addSubview(workoutLibraryLabel)
        workoutLibraryLabel.anchor(top: theDayWorkoutButton.bottomAnchor, left: scroll.leftAnchor, paddingTop: 5, paddingLeft: 30, width: screenWidth, height: 30)
        
        scroll.addSubview(collectionView)
        collectionView.anchor(top: workoutLibraryLabel.bottomAnchor, left: scroll.leftAnchor, paddingTop: 5, paddingLeft: 30, paddingRight: 30, width: screenWidth - 60, height: CGFloat(175 * numberOfItems / 2))
        
        return scroll
    }()
    
    
    
    let theDayWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Workout of the Day"
        label.font = UIFont(name: "Helvetica", size: 25)
        return label
    }()
    
    let theDayWorkoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        button.setBackgroundImage(UIImage(named: "theDayWorkoutButtonBkg"), for: UIControl.State())
        button.tag = 0
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let workoutLibraryLabel: UILabel = {
        let label = UILabel()
        label.text = "Workout Library"
        label.font = UIFont(name: "Helvetica", size: 25)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let screenFrame = UIScreen.main.bounds
        let screenWidth = screenFrame.size.width
        let screenHeight = screenFrame.size.height
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 160, height: 160)
        layout.minimumLineSpacing = 25
        
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth - 40, height: 800), collectionViewLayout: layout)

        view.backgroundColor = UIColor.white
        view.delegate = self
        view.dataSource = self
        view.register(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "itemId")
        return view
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        let screenFrame = UIScreen.main.bounds
        let screenWidth = screenFrame.size.width
        
        scrollView.contentSize = CGSize(width: screenWidth, height: CGFloat(175 * numberOfItems / 2 + 280))
    }
    
    
    @objc func btnClick(btn:UIButton) {
        print("btn")
        let viewController = WorkoutViewController()
        viewController.modalPresentationStyle = .fullScreen
        switch btn.tag {
        case 0:
            viewController.tag = "Workout of the Day"
        case 1:
            viewController.tag = "Push-up"
        case 2:
            viewController.tag = "Sit-up"
        case 3:
            viewController.tag = "Plank"
        case 4:
            viewController.tag = "Squat"
        default:
            print("Error")
            break
        }
        self.present(viewController, animated: true, completion: nil)
    }
    
    // 1、已经开始滚动（不管是拖、拉、放大、缩小等导致）都会执行此函数
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    // 2、将要开始拖拽，手指已经放在view上并准备拖动的那一刻
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
//3、将要结束拖拽，手指已拖动过view并准备离开手指的那一刻，注意：当属性isPagingEnabled为YES时，此函数不被调用
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    // 4、已经结束拖拽，手指刚离开view的那一刻
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    // 5、view将要开始减速，view滑动之后有惯性
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    // 6、view已经停止滚动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    // 7、view的缩放
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    // 8、有动画时调用
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }

}
