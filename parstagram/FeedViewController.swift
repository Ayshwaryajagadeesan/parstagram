//
//  FeedViewController.swift
//  parstagram
//
//  Created by Arun Deepak Sampath Kumar on 10/23/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit
import Parse
class FeedViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
 @IBOutlet weak var tableView: UITableView!
      var posts = [PFObject]()
      var numberofPosts : Int!
      var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPosts()
        
        
    }
    @objc func loadPosts(){
        //self.posts.removeall()
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        numberofPosts = 20
        query.limit = numberofPosts
        query.findObjectsInBackground { (posts,error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
                self.run(after: 2) {
                   self.refreshControl.endRefreshing()
                }
                
                
                
            }
        }
        
    }
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
   
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as! String
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.photoView.af_setImage(withURL: url)
        
        
        
        return cell
    }
    
    func loadMorePosts(){
           let query = PFQuery(className:"Posts")
           query.includeKey("author")
           numberofPosts = numberofPosts + 20
           query.limit = numberofPosts
           query.findObjectsInBackground { (posts,error) in
               if posts != nil {
                   self.posts = posts!
                   self.tableView.reloadData()
                   self.run(after: 2) {
                      self.refreshControl.endRefreshing()
                   }
                   
                   
                   
               }
           }
           }
       
       
    func tableView(_ tableView:UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
       {
           if indexPath.row + 1 == posts.count {loadMorePosts() }
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
