//
//  PublicImageTableViewController.swift
//  FlickrApp
//
//  Created by Michael Modvig on 30/11/2016.
//  Copyright © 2016 Michael Modvig. All rights reserved.
//

import UIKit
import PKHUD

class PublicImageTableViewController: UITableViewController {
    var imageSet = [[String: Any]]()
    var session : URLSession?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create new instance and show PKHUD
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        
        /*
        let config = URLSessionConfiguration()
        config.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession(configuration: config)
        */
        
        let f = FlickrSDK.sharedInstance
        f.getPublicImages() { (error, images) in
            if(error != nil) {
                return
            }
            self.imageSet = images!
        
            self.tableView.reloadData()
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageSet.count
    }
    
    func imageTapped(img: AnyObject)
    {
        //print(img)
        
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PublicImageTableViewCell
        let imageURL = URL(string: (self.imageSet[indexPath.row]["media"] as! [String : String])["m"]!)
        let imageTitle = self.imageSet[indexPath.row]["title"] as! String
        
        var imageCounter = 0
        
        // Configure the cell...
        cell.il.text = imageTitle
        let t = URLSession.shared.dataTask(with: imageURL!){ (data,request,error) in
            imageCounter += 1
            let img = UIImage(data: data!)
            DispatchQueue.main.async {
                cell.iv.image = img!
                
                //Enable tapGestureRecognizer for fullscreen view of image
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(img:)))
                cell.iv.isUserInteractionEnabled = true
                cell.iv.addGestureRecognizer(tapGestureRecognizer)
                
                imageCounter -= 1
                //Disable PKHUD
                if(imageCounter == 0) {
                    PKHUD.sharedHUD.hide()
                }
                
                
            }
        }
        
        t.resume()
        
        return cell
    }
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
