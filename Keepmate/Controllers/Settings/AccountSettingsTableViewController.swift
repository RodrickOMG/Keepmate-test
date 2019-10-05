//
//  AccountSettingsTableViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/10/1.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit

class AccountSettingsTableViewController: UITableViewController {
    
    let firstArray = ["电子邮箱", "更改个人资料", "运动仅自己可见"]
    let secondArray = ["训练目标"]
    let thirdArray = ["绑定微博", "绑定微信"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "帐号设置"
        
        view.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        //上下没有效果
        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = 0
        if section == 0 {
            rows = firstArray.count
        } else if section == 1 {
            rows = secondArray.count
        } else {
            rows = thirdArray.count
        }
        return rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = .init(style: .value1, reuseIdentifier: "AccountSettingsItemCell")
        
        let user = BmobUser.current()
        
        if indexPath.section == 0{
            cell.textLabel?.text = firstArray[indexPath.row]
            if firstArray[indexPath.row] == "电子邮箱" {
                cell.detailTextLabel?.text = user?.email
                cell.detailTextLabel?.textColor = .gray
            } else if firstArray[indexPath.row] == "更改个人资料" {
                cell.accessoryType = .disclosureIndicator
            } else if firstArray[indexPath.row] == "运动仅自己可见" {
                let switchObj = UISwitch(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
                switchObj.isOn = false
                cell.accessoryView = switchObj
            }
        } else if indexPath.section == 1 {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = secondArray[indexPath.row]
        } else if indexPath.section == 2{
            cell.textLabel?.text = thirdArray[indexPath.row]
            let switchObj = UISwitch(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
            switchObj.isOn = false
            cell.accessoryView = switchObj
        }
        return cell
    }


    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       // UIView with darkGray background for section-separators as Section Header
       let v = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 35))
       v.backgroundColor = .settingsBkgColor
       return v
   }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if firstArray[indexPath.row] == "更改个人资料" {
                let sb = UIStoryboard(name:"Settings",bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "UpdateProfileInfo")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
