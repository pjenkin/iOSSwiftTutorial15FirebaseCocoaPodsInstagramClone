//
//  SecondViewController.swift
//  Insta Clone Firebase
//
//  Created by Peter Jenkin on 09/04/2019.
//  Copyright © 2019 Peter Jenkin. All rights reserved.
//

import UIKit
import Photos


class uploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postComment: UITextView!
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

