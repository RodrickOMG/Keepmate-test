//
//  ProfileScrollView.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/7/17.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
     }
     */

    var scroll:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenFrame = UIScreen.main.bounds
        let screenWidth = screenFrame.size.width
        let screenHeight = screenFrame.size.height
        view.backgroundColor = UIColor.white
        scroll = UIScrollView(frame: view.bounds)
        
        let userInfo = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight*1.2*0.2))
        userInfo.backgroundColor = UIColor.lightGray
        scroll.addSubview(userInfo)
        
        let statsLabel = UILabel(frame: CGRect(x: 5, y: screenHeight*1.2*0.2 + 5, width: 50, height: 15))
        statsLabel.text = "STATS"
        statsLabel.font = UIFont(name: "Chalkboard SE", size: 12)
        scroll.addSubview(statsLabel)
        
        //内容大小，小于scrollView的大小不会scroll
        scroll.contentSize = CGSize(width: screenWidth, height: view.bounds.height*1.2)
        //但是可以设定，内容就算小于它，也能拖：
        scroll.alwaysBounceVertical = true //还有水平的
        //内容的初始位置偏移到指定point处
        //scroll.contentOffset = CGPoint(x: 20, y: 20)
        //拉到头时可否反弹 default为true
        scroll.bounces = true
        //拖时候不能改变方向。但往对角线方向开始拖，可以自由拖
        scroll.isDirectionalLockEnabled = false //default false
        //翻页效果，true就是手滑动小了回到原位置，大了直接跳下一页
        scroll.isPagingEnabled = false
        //scroll.isScrollEnabled = false //false就不能滑了==
        //点状态栏回到最上方
        scroll.scrollsToTop = true;
        //滚动条到屏幕边缘的距离 offset <-> inset ,offset偏移，inset内移
        scroll.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        //add additional scroll area around content
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //是否显示滚动条
        scroll.showsVerticalScrollIndicator = true //还有水平的
        scroll.indicatorStyle = .black //默认黑，黑白两色可选
        function()
        scroll.bouncesZoom = true
        //如果正显示着键盘，拖动，则键盘撤回
        scroll.keyboardDismissMode = .onDrag
        //scroll.refreshControl = UIRefreshControl(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        
        //        open var decelerationRate: CGFloat
        
        //        open var indexDisplayMode: UIScrollViewIndexDisplayMode
        
        //现在实现ScrollViewDelegate,补充后面的协议方法
        
        scroll.delegate = self
        view.addSubview(scroll)
    }
    func function(){
        //滚动条突然显现一下
        scroll.flashScrollIndicators()
    }
    //点击状态栏时触发，返回false则不能滑上去 相应的 didScrollToTop是已经回了调用的
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    //开始拖拽前：
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }//拖拽结束
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    //滚动动画结束
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
}

