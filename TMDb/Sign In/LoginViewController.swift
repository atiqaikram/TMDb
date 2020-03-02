//
//  LoginViewController.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 28/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        guard let signIn = GIDSignIn.sharedInstance() else { return }
        if (signIn.hasPreviousSignIn()) {
            signIn.restorePreviousSignIn()
            if (signIn.currentUser.authentication.clientID != CLIENT_ID) {
                signIn.signOut()
            }
        }
        let signInButton = GIDSignInButton(frame: CGRect(x: 0,y: 0,width: 230, height: 48))
        signInButton.center = view.center
        view.addSubview(signInButton)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        } else{
            guard let id = user.userID else { return }
            userID.shared.setID(sentId: id)
            if let movieViewController = storyboard?.instantiateViewController(withIdentifier: "MoviesStoryboard") as? MoviesViewController {
                self.navigationController?.pushViewController(movieViewController, animated: true)
            }
           /* guard let email = user.profile.email else { return }*/
        }
    }
}
