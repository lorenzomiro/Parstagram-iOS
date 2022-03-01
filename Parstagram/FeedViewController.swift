//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Miro on 2/26/22.
//

import UIKit

import Parse

import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var posts = [PFObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        
        query.includeKey("author")
        
        query.limit = 20
        
        query.findObjectsInBackground() { (posts, error) in
            
            if posts != nil {
                
                self.posts = posts!
                
                self.tableView.reloadData()
                
            }
            
//            self.loadMorePosts()
            
        }
        
    }
    
    func loadMorePosts() {
        
        let query = PFQuery(className: "Posts")
        
        query.includeKey("author")
        
        query.limit = query.limit + 10
        
        query.findObjectsInBackground() { (posts, error) in
            
            if posts != nil {
                
                self.posts = posts!
                
                self.tableView.reloadData()
                
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        //grab posts
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as! String
        
        let imgFile = post["image"] as! PFFileObject
        
        let urlString = imgFile.url!
        
        print(urlString)
        
        let url = URL(string: urlString)!
        
        cell.photoView.af.setImage(withURL: url)
        
        return cell
        
        
        
    }



}
