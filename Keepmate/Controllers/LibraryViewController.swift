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
    
    let numberOfItems = 6
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
        
        switch tagOfButtons {
        case 0:
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            btn.backgroundColor = UIColor.gray
            btn.setBackgroundImage(UIImage(named: "theDayWorkoutButtonBkg"), for: UIControl.State())
            btn.tag = 1
            cell.addSubview(btn)
        case 1:
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            btn.backgroundColor = UIColor.red
            btn.tag = 2
            cell.addSubview(btn)
        case 2:
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            btn.backgroundColor = UIColor.blue
            btn.tag = 3
            cell.addSubview(btn)
        case 3:
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            btn.backgroundColor = UIColor.yellow
            btn.tag = 4
            cell.addSubview(btn)
        default:
            print("Error")
        }
        
        tagOfButtons += 1
        return cell
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = UIScreen.main.bounds
        let screenWidth = screenFrame.size.width
        let screenHeight = screenFrame.size.height
        view.backgroundColor = UIColor.white
        scroll = UIScrollView(frame: view.bounds)

        let Label1 = UILabel(frame: CGRect(x: 25, y: 5, width: screenWidth, height: 30))
        Label1.text = "Workout of the Day"
        Label1.font = UIFont(name: "Helvetica", size: 25)
        self.scroll.addSubview(Label1)
        
        let theDayWorkout = UIButton(frame: CGRect(x: 25, y: 45, width: screenWidth - 50, height: screenHeight * 0.25))
        theDayWorkout.backgroundColor = UIColor.red
        theDayWorkout.setBackgroundImage(UIImage(named: "theDayWorkoutButtonBkg"), for: UIControl.State())
        theDayWorkout.tag = 0
        theDayWorkout.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        theDayWorkout.layer.cornerRadius = 5
        theDayWorkout.layer.masksToBounds = true
        self.scroll.addSubview(theDayWorkout)
        
        let Label2 = UILabel(frame: CGRect(x: 25, y: screenHeight * 0.25 + 60, width: screenWidth, height: 30))
        Label2.text = "Workout Library"
        Label2.font = UIFont(name: "Helvetica", size: 25)
        self.scroll.addSubview(Label2)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 25
        let collectionView = UICollectionView(frame: CGRect(x: 25, y: screenHeight * 0.25 + 100, width: screenWidth - 50, height: 600), collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "itemId")
        self.scroll.addSubview(collectionView)
        
        scroll.contentSize = CGSize(width: screenWidth, height: screenHeight * 0.25 + 660)
        scroll.alwaysBounceVertical = true
        scroll.bounces = true
        scroll.isDirectionalLockEnabled = false //default false
        scroll.isPagingEnabled = false
        scroll.scrollsToTop = true;
        scroll.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scroll.showsVerticalScrollIndicator = true //还有水平的
        scroll.indicatorStyle = .black //默认黑，黑白两色可选
        function()
        scroll.bouncesZoom = true
        //如果正显示着键盘，拖动，则键盘撤回
        scroll.keyboardDismissMode = .onDrag
        
        scroll.delegate = self
        view.addSubview(scroll)
        
    }
    
    func function(){
        //滚动条突然显现一下
        scroll.flashScrollIndicators()
    }
    
    @objc func btnClick(btn:UIButton) {
    self.present(WorkoutViewController(), animated: true, completion: nil)
    }
    
}
