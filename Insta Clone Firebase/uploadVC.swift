//
//  SecondViewController.swift
//  Insta Clone Firebase
//
//  Created by Peter Jenkin on 09/04/2019.
//  Copyright © 2019 Peter Jenkin. All rights reserved.
//

import UIKit
import Photos
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class uploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postComment: UITextView!
    
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        postImage.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.choosePhoto))
        postImage.addGestureRecognizer(recognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func postBtnClicked(_ sender: Any) {
        //let mediaFolder = Storage.storage().reference().child("media")
        let mediaFolder = Storage.storage().reference().child("media").child("\(uuid).jpg")
        // folder 'media' previously formed in Storage in Firebase console
        // 'Storage' as base, 'media' as child
        // save as randomly generated name (UUID string) each time
        if let data = UIImageJPEGRepresentation(postImage.image!, 0.5)
        {
            guard let userId = Auth.auth().currentUser?.uid else
            {
                print ("User not authenticated - no can upload")
                return
            }
                    // https://stackoverflow.com/a/53929727
            let StorageRef = mediaFolder.child(userId)
            //mediaFolder.child("\(uuid).jpg").putData(data, metadata: nil) { (metadata, error) in // - deprecated
            StorageRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    
                    alert.addAction(okButton)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    print("upload path: \(String(describing:metadata?.path))")
                    
                }
                else   // if there's no problem with the file storage, go ahead
                {
                    // let imageUrl = metadata?.downloadURL()?.absoluteString   // deprecated
                    
                    // downloadUrl must be obtained with async completion/closure, and authentication must be used if the Firebase storage rules are set to same e.g. allow read, write: if request.auth != null; https://stackoverflow.com/a/50464820

                    StorageRef.downloadURL(completion: { (url, error) in
                        if error != nil
                        {
                            print("Error getting download url: \(String(describing: error?.localizedDescription))")
                        }
                        else
                        {
                            print("url: \(String(describing: url!.absoluteURL))")
                        }
                    })
                    
                }
            // putFile(from: // , metadata: <#T##StorageMetadata?#>, completion: <#T##((StorageMetadata?, Error?) -> Void)?##((StorageMetadata?, Error?) -> Void)?##(StorageMetadata?, Error?) -> Void#>)
            
            }
        }
    }
    

    // #selector'd function on image tap
    func choosePhoto()
    {
        let picker = UIImagePickerController()
        picker.delegate = self      // need to subclass ViewController (self) as delegate for UIIMagePickerController and UINavigationController, therefore
        picker.sourceType = .photoLibrary       // could be camera as source
        present(picker, animated: true, completion: nil)
    }
    
    // get here by auto-complete 'didfinish...'
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?   // workaround to get original image https://stackoverflow.com/a/53219069
        
        // postImage.image = info[UIImagePickerControllerEditedImage] as? UIImage // didn't work as original image slipped through unused - no edited image to use
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {   // NB Any type from dictionary - try to cast to UIImage
            selectedImageFromPicker = editedImage
        }
        else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            selectedImageFromPicker = originalImage
        }
        
        // cautious approach here!
        if let selectedImage = selectedImageFromPicker
        {
            postImage.image = selectedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }

        
}

