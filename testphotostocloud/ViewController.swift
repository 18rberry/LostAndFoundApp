//
//  ViewController.swift
//  testphotostocloud
//
//  Created by Lauren Traum on 3/2/18.
//  Copyright © 2018 Lauren Traum. All rights reserved.
//
//this is Lauren. Lauren. Lauren

import UIKit
import Firebase
import GoogleSignIn



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var whoFoundUserText: UITextField!
    @IBOutlet weak var dateFoundUserText: UITextField!
    @IBOutlet weak var whereFoundUserText: UITextField!
    @IBOutlet weak var descriptionUserText: UITextField!
    
    @IBOutlet weak var pullDownFromFirebase: UITextView!
    var tableItems = ["dog"]
    var foundItems: DatabaseReference!
    @IBOutlet weak var PhotoLibrary: UIButton!
    @IBOutlet weak var Camera: UIButton!
    @IBOutlet weak var ImageDisplay: UIImageView!
    var foundItemsList = [FoundItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        foundItems = Database.database().reference().child("found items")
        
        print()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")
        
        cell?.textLabel?.text = self.tableItems[indexPath.row]
        
        return cell!
    }
    
    func addFoundItem(){
        let key = foundItems.childByAutoId().key
        let foundItem = ["id":key,
                         "foundItemLocation" : whereFoundUserText.text,
                         "foundItemDescription": descriptionUserText.text,
                         "foundItemDateFound": dateFoundUserText.text] as [String : Any]
        foundItems.child(key).setValue(foundItem)
        print("item added")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func submit(_ sender: UIButton) {
        addFoundItem()
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.whoFoundUserText.text = ""
                self.dateFoundUserText.text = ""
                self.whereFoundUserText.text = ""
                self.descriptionUserText.text = ""
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func PhotoLibraryAction(_ sender: UIButton) {
        
       let picker = UIImagePickerController()
        
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func CameraAction(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        
        
        picker.delegate = self
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        ImageDisplay.image=info[UIImagePickerControllerOriginalImage] as? UIImage; dismiss(animated: true, completion: nil)
    }
    
    
}

