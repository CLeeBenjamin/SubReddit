//
//  SubRedditTableViewController.swift
//  SubReddit
//
//  Created by Caston  Boyd on 5/23/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

class SubRedditTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var redditSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        redditSearchBar.delegate = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
        redditSearchBar.setImage(UIImage(named: "icons8-reddit-50.png"), for: .search, state: .normal)
        let logo = UIImage(named: "reddit-icon")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        imageView.contentMode = .scaleAspectFit
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let theUsersSearch = redditSearchBar.text else  { return }
        redditSearchBar.text = ""
        
        SubRedditController.sharedInstance.fetchPostwith(searchName: theUsersSearch) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
        redditSearchBar.resignFirstResponder()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return SubRedditController.sharedInstance.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "redditCell", for: indexPath) as? SubRedditTableViewCell else { return UITableViewCell() }
        
        let post = SubRedditController.sharedInstance.posts[indexPath.row]
     
        SubRedditController.sharedInstance.fetchImage(withURL: post.thumbnail) { (newImage) in
            DispatchQueue.main.async {
                 cell.posts = post
                if let currentPath = self.tableView.indexPath(for: cell),
                    currentPath == indexPath {
                    cell.thumbNail = newImage
                } else {
                    print("Got image for now-reused cell")
                    return
                    
                }
            }
        }
     

        return cell
    }




}
