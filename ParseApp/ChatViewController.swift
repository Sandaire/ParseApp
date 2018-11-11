//
//  ChatViewController.swift
//  ParseApp
//
//  Created by Sandyna Sandaire Jerome on 11/7/18.
//  Copyright © 2018 Sandyna Sandaire Jerome. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgField: UITextField!

    
    
    let currentusr = PFUser.current()!
    var msg = [PFObject]()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        refreshControl = UIRefreshControl()
       refreshControl.addTarget(self, action: #selector(ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        loadData()
        tableView.insertSubview(refreshControl, at: 0)
        self.tableView.reloadData()
        tableView.separatorStyle = .none
        
        
        // Auto size row height based on cell autolayout constraints
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 150
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 150
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        loadData()
    }
    
    @objc func loadData(){
        // construct query
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                
                for message in posts{
                    if (message["text"] != nil)
                    {
                        print(message["text"]!)
                    }else{
                        print("no text")
                    }
                }
                self.msg = posts
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print(error?.localizedDescription)
                
            }
        }
        self.tableView.reloadData()
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("TOTAL MSG : \(msg.count)")
        return msg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCellul") as! ChatCell
        
        let chat = msg[indexPath.row]
        if let user = chat["user"] as? PFUser {
            cell.userLabel.text = user.username
        }else{
            cell.userLabel.text = "🤖"
        }
        cell.msgLabel.text = (chat["text"] as! String)
        
        cell.msgLabel.layer.cornerRadius = 16
        cell.msgLabel.clipsToBounds = true
        
        cell.userLabel.layer.cornerRadius = 50
        cell.userLabel.clipsToBounds = true
       
        return cell
    }
    
    
    @IBAction func sendMSG(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        let currentuser = PFUser.current()!
        chatMessage["text"] = msgField.text ?? ""
        chatMessage["user"] = currentuser
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.msgField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
