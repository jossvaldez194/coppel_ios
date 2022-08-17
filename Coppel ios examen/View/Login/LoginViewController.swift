//
//  ViewController.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 12/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    let api_base = "https://api.themoviedb.org/3/"
    let url_auth = "authentication/token/new?api_key="
    let url_login = "authentication/token/validate_with_login"
    let api_key = "f48e69d6a8485ef2819154aca28c93cd"
    
    var mUser : String = ""
    var mPassWord : String = ""
    
    var loginButton = CustomUIButton()
    
    private var loginViewModel : LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        /*print("Button pressed")
        mUser = tfUser.text ?? ""
        mPassWord = tfPassword.text ?? ""
        callToViewModelForUIUpdate()*/
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as? HomeTMDBViewController
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }

    //--------------------------------------------------------------------------//
    func callToViewModelForUIUpdate(){
        self.loginViewModel =  LoginViewModel()
        //self.loginViewModel.sendRequestGetPopular()
        //self.loginViewModel.sendRequestGetTopRated()
        self.loginViewModel.sendRequestGetOnTheAir()
        //self.loginViewModel.sendRequestGetAiringToday()
        self.loginViewModel.sessionDataBind = { [weak self]  in
            DispatchQueue.main.async {
                
               
                
                /*let viewControllerB = HomeTMDBViewController()
                self?.navigationController?.pushViewController(viewControllerB, animated: true)*/
            }
        }
    }
        
    func updateDataSource(){
           
    }
}
