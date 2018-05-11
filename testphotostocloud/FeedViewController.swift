//
//  FeedViewController.swift
//  testphotostocloud
//
//  Created by Lauren Traum on 3/29/18.
//  Copyright © 2018 Lauren Traum. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class FeedViewController: UIViewController, GIDSignInUIDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var foundItems: DatabaseReference!
    var foundItemsList = [FoundItemModel]()
    
    @IBAction func buttonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "addItem", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        foundItems = Database.database().reference().child("found items");
        
        //observing the data changes
        foundItems.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.foundItemsList.removeAll()
                
                //iterating through all the values
                for foundItems in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let foundObject = foundItems.value as? [String: AnyObject]
                    let foundItemLocation  = foundObject?["foundItemLocation"]
                    let foundItemDescription  = foundObject?["foundItemDescription"]
                    let foundItemDateFound = foundObject?["foundItemDateFound"]
                    let foundItemId = foundObject?["id"]
                    
                    //creating artist object with model and fetched values  *************************
                    let foundItem = FoundItemModel(id: foundItemId as! String?, dateFound: foundItemDateFound as! String?, description: foundItemDescription as! String?, location: foundItemLocation as! String?)
                    
                    
                    //appending it to list
                    self.foundItemsList.insert(foundItem, at: 0)
                    print(foundItem.id!)
                }
                
                //reloading the tableview
                self.tableView.reloadData()
            }
        })
        
        // Doing in AppDelegate.swift
        //GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func onAddTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Post Something", message: "What would you like to post?", preferredStyle: .alert)
        alert.addTextField{ (textField) in
            textField.placeholder = "Enter message here"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let post = UIAlertAction(title: "Post", style: .default) { _ in
            guard let text = alert.textFields?.first?.text else { return }
            print(text)
        }
        alert.addAction(cancel)
        alert.addAction(post)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addPost(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as? ViewControllerTableViewCell
        
        cell?.labelFoundItemDateFound.text = self.foundItemsList[indexPath.row].dateFound
        cell?.labelFoundItemDescription.text = self.foundItemsList[indexPath.row].description
        cell?.labelFoundItemLocation.text = self.foundItemsList[indexPath.row].location
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foundItemsList.count
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





