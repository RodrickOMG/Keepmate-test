//
//  SettingsTableViewController.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/9/14.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    let firstArray = ["账号管理", "账号与安全"]
    let secondArray = ["推送通知设置", "隐私设置", "通用设置"]
    let thirdArray = ["客服中心", "关于Keepmate"]
    let logOutArray = ["退出登录"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .settingsBkgColor
        tableView.delegate = self
        //上下没有效果
        //tableView.separatorInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0
        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserOperationItemCell", for: indexPath)
        if indexPath.section == 0{
            cell.textLabel?.text = firstArray[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = secondArray[indexPath.row]
        } else if indexPath.section == 2{
            cell.textLabel?.text = thirdArray[indexPath.row]
        } else {
            cell.textLabel?.text = logOutArray[indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.red
        }
        return cell
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = 0
        if section == 0{
            rows = firstArray.count
        } else if section == 1 {
            rows = secondArray.count
        } else if section == 2{
            rows = thirdArray.count
        } else {
            rows = logOutArray.count
        }
        return rows
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // UIView with darkGray background for section-separators as Section Footer
        let v = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 35))
        v.backgroundColor = .settingsBkgColor
        return v
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (logOutArray[indexPath.row] == "退出登录") {

            let alert = UIAlertController(title: "", message: "退出后不会删除任何历史数据，下次登录依然可以使用本帐号", preferredStyle: .actionSheet)
            let logOutAction = UIAlertAction(title: "退出登录", style: UIAlertAction.Style.destructive, handler:  { (action) in
                print("Log Out")
                BmobUser.logout()
                let sb = UIStoryboard(name:"LoginAndRegister",bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "Login")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            })

            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)

            alert.addAction(logOutAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
            }

        }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
