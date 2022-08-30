//
//  ProfileViewController.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 17/08/22.
//

import UIKit

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var profileViewModel : ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewModel = ProfileViewModel()
        settupObserver()
    }

    private func settupObserver(){
        self.profileViewModel.profileDataBinding = { [weak self]  in
            DispatchQueue.main.async {
                self?.settupViews()
            }
        }
    }
    
    private func settupViews(){
        imgAvatar.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        if (profileViewModel.profileData?.avatar.tmdb.avatarPath != nil){
            imgAvatar.loadFrom(URLAddress: Constants.BASE_IMAGE + (profileViewModel.profileData?.avatar.tmdb.avatarPath ?? ""))
        }else{
            imgAvatar.image = UIImage(named: "avatar")
        }
        
        lblName.text = profileViewModel.profileData?.username
       
    }

}
