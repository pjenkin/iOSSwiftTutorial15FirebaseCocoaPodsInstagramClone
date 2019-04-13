//
//  FirstViewController.swift
//  Insta Clone Firebase
//
//  Created by Peter Jenkin on 09/04/2019.
//  Copyright © 2019 Peter Jenkin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    @IBOutlet weak var postImage: UIImageView!
//    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var tableView: UITableView!

    var userEmailArray = [String]()
    var postCommentArray = [String]()
    var postImageUrlArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 2 required delegate functions for tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return 10
        return userEmailArray.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! postCell
        //cell.usernameLabel
        //var t = cell.usernameLabel.text
        print(postCommentArray[indexPath.row])
        print(userEmailArray[indexPath.row])
        
        // print(cell.postComment?.text)
        
        cell.postComment.text = postCommentArray[indexPath.row]
        // cell.postComment.text = "hello"
        cell.usernameLabel.text = "hello" + userEmailArray[indexPath.row]
        cell.postImage.sd_setImage(with: URL(string: self.postImageUrlArray[indexPath.row]))
        // SDWeb Image https://github.com/SDWebImage/SDWebImage
        return cell;
    }

    
    
    // set height of prototype cell programmatically using delegate function https://stackoverflow.com/a/46438939
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    
    // https://slicode.com/collectionview-inside-tableview-cell-part-1/ ?
    // https://www.techotopia.com/index.php/An_iOS_7_Storyboard-based_Collection_View_Tutorial
    // https://www.techotopia.com/index.php/Using_Storyboards_and_Swift_to_Build_Dynamic_TableViews_with_Prototype_Table_View_Cells#Designing_a_Storyboard_UITableView_Prototype_Cell
/*
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) as! feedCell
        
        // cell.imageView.image = images[indexPath.row]
        
        return cell
    }
*/
    
    func getDataFromServer()
    {
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            print("snapshot.value: \(snapshot.value)")
            print("snapshot.key: \(snapshot.key)")
            // snapshot key is the user's unique id / uuid
            // snapshot value is the actual post (dictionary of field key/value pairs)
            // how to traverse structure
            
            let values = snapshot.value! as! NSDictionary
            
            let post = values["post"] as! NSDictionary
            // actually a dictionary of dictionaries (individual posts are dictionaries of about 4 fields|key/value pairs)
            
            print(post)
            
            let postIds = post.allKeys  // use NSDictionary method to search keys for posts sought
            
            for id in postIds
            {
                let singlePost = post[id] as! NSDictionary
                // search within fields eg 'postedBy' 'field' in post
                print("username: \(singlePost["postedBy"])")
                print("postText: \(singlePost["postText"])")
                print("image: \(singlePost["image"])")
                
                self.userEmailArray.append(singlePost["postedBy"] as! String)
                self.postCommentArray.append(singlePost["postText"] as! String)
                self.postImageUrlArray.append(singlePost["image"] as! String)
            }
            
            // refresh view after fetching data from server
            self.tableView.reloadData()
        }
        
        // could be childAdded, Removed, Changed, Moved
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user")
            UserDefaults.standard.synchronize()
        
        
        let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signInVC") as! signInVC
        // need to have, using Identity Inspector, StoryboardID assigned to signInVC ("signInVC")
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signIn    // set start back to signIn having logged out
        
        delegate.rememberLogin()                        // update logged-in status (ie not)
    }
}

