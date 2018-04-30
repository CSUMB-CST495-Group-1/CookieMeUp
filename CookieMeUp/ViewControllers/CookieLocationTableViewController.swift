//
//  CookieLocationTableViewController.swift
//  CookieMeUp
//
//  Created by Raquel Figueroa-Opperman on 4/25/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import UIKit
import Parse

class CookieLocationTableViewController: UIViewController, UITableViewDataSource {
    var refreshControl: UIRefreshControl!
    @IBOutlet var cookieLocationTableView: UITableView!
    var locations: [PFObject] = []
    var users: PFUser? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        
        cookieLocationTableView.rowHeight = UITableViewAutomaticDimension
        cookieLocationTableView.rowHeight = 175
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(CookieLocationTableViewController.didPullToRefresh(_:)), for: .valueChanged)
        cookieLocationTableView.insertSubview(refreshControl!, at: 0)
        cookieLocationTableView.dataSource = self
        
        fetchLocations()
        
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.fetchLocations), userInfo: nil, repeats: true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func fetchLocations() {
//        print ("Get Locations!")
        let query = PFQuery(className:"CookieLocation")

        //         fetch data asynchronously
        query.findObjectsInBackground { (locations: [PFObject]?, error: Error?) -> Void in
            if let locations = locations {
                self.locations = locations
                self.cookieLocationTableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print(error!.localizedDescription)
                if (error!.localizedDescription == "The Internet connection appears to be offline."){
                    //alert functionality:
                    let alertController = UIAlertController(title: "Network Connection Failure", message: "The Internet connection appears to be offline. Would you like to reload?", preferredStyle: .alert)

                    let cancelAction = UIAlertAction(title: "Cancel: Exit App", style: .cancel) { (action) in
                        exit(0)
                    }

                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.fetchLocations()
                    }

                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)

                    self.present(alertController, animated: true){
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cookieLocationTableView.dequeueReusableCell(withIdentifier: "CookieLocationCell", for: indexPath) as! CookieLocationCell
        let location = locations[indexPath.row]

        cell.long.text = (location["longitude"] as AnyObject).description
        cell.lat.text = (location["latitude"] as AnyObject).description
        cell.startTime.text = (location["start_time"] as! String)
        cell.endTime.text = (location["end_time"] as! String)

        let userQuery = location["user"] as! PFUser
        let userId = userQuery.objectId as! String
        let query = PFQuery(className:"_User")
        let queriedUser = query.includeKey(userId)
  
        do {
            let user = try queriedUser.getObjectWithId(userId)
            cell.user.text = (user["username"] as! String)

        } catch {
            print("error")
        }


        return cell

    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchLocations()
    }








}
