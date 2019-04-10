//
//  signInVC.swift
//  Insta Clone Firebase
//
//  Created by Peter Jenkin on 09/04/2019.
//  Copyright © 2019 Peter Jenkin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth     // &c - has its own pod


// would need to add to Podfile:
/*
 pod 'Firebase/Core'
 pod 'Firebase/Auth'
 pod 'Firebase/Database'
 pod 'Firebase/Storage'
 */
// and 'pod install' again

class signInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func signInBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toTabBar", sender: nil)
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""
        {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                if error != nil
                {   // if there's an error, tell user
                    // copy/paste of below code, & alter to allow sepcific error message!
                    let alert = UIAlertController(title: "Error", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    // NB alert is Controller, ok is Action
                    
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    // set up a warning to user in case of eror
                }
                else
                {
                    print(user?.user.email) // NB extra .user  https://stackoverflow.com/a/50419010
                    // print(user?.email)
                    print("successful sign-up")
                }
            }  // completion:<#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#> NB pressing enter can expand into block if appropriate, as above wit (user, error) in ....
        
        } else
        {
            let alert = UIAlertController(title: "Error", message: "Problem signing up", preferredStyle: UIAlertControllerStyle.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            // set up a warning to user in case of eror
        }
    }
}
