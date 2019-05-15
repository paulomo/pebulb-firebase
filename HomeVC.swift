//
//  HomeVC.swift
//  Petbulb
//
//  Created by MACPRO on 2017-11-13.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import SDWebImage


class HomeVC: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var cameraPostButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var posts = [Post]()
    var users = [User]()
    var postIdentifier = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.estimatedRowHeight = 515
        homeTableView.rowHeight = UITableViewAutomaticDimension
        
        loadPostFromFirbase()
        
    }
    
    func loadPostFromFirbase() {
        activityIndicatorView.startAnimating()
        Database.database().reference().keepSynced(true)
        Database.database().reference().child("posts").observe(DataEventType.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let post = Post.transformPostPhoto(dict: dict)
                self.fetchUser(uid: post.uid!, completed: {
                    self.posts.append(post)
                    self.activityIndicatorView.stopAnimating()
                    self.homeTableView.reloadData()
                })
            }
        }
    }
    
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: DataEventType.value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let user = User.transformUser(dict: dict)
                self.users.append(user)
                completed()
            }
        })
    }
    
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if post.postType == "photo" {
            postIdentifier = "PostCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: postIdentifier, for: indexPath) as! HomeTableViewCell
            let user = users[indexPath.row]
            cell.post = post
            cell.user = user
            return cell
            
        }else if post.postType == "text" {
            postIdentifier = "TextCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: postIdentifier, for: indexPath) as! TextTableCell
            let user = users[indexPath.row]
            cell.postText = post
            cell.user = user
            return cell
        }else if post.postType == "advice" {
            let cell = tableView.dequeueReusableCell(withIdentifier: postIdentifier, for: indexPath) as! HomeTableViewCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: postIdentifier, for: indexPath) as! HomeTableViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.dequeueReusableCell(withIdentifier: "PostCell") != nil) {
            
            
        }
    }
    
    
    
}
