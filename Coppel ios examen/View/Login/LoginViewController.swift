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
    
    var mUser : String = ""
    var mPassWord : String = ""
    
    var statusRequest : String?
    
    private var loginViewModel : LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewModel =  LoginViewModel()
        callToViewModelForToken()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        mUser = tfUser.text ?? ""
        mPassWord = tfPassword.text ?? ""
        initObservers()
        loginViewModel.sendRequestCreateSession(user: mUser, pasw: mPassWord)
        
    }
    
    private func initObservers(){
        callToViewModelForSession()
    }
    
    func callToViewModelForSession(){
        self.loginViewModel.successDataBind = { [weak self]  in
            DispatchQueue.main.async {
                if (self?.loginViewModel.success?.isEmpty ?? false){
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as? HomeTMDBViewController
                self?.navigationController?.popViewController(animated: true)
                self?.navigationController?.pushViewController(vc!, animated: true)
                }else{
                    self?.lblErrorMessage.isHidden = false
                    self?.lblErrorMessage.text = "No se puede acceder a la aplicación"
                }
            }
        }
        //self.loginViewModel.sendRequestCreateToken(user: mUser, pasw: mPassWord)
    }
    
    func callToViewModelForToken(){
        self.loginViewModel.tokenDataBind = { [weak self]  in
            DispatchQueue.main.async {
                if (self?.loginViewModel.userTokenValue != nil){
                    self?.openWebNavigator()
                }
                
            }
        }
    }
    
    private func openWebNavigator(){
        if let url = URL(string: "https://www.themoviedb.org/authenticate/\(self.loginViewModel.userTokenValue.request_token)") {
            UIApplication.shared.open(url)
        }
    }
    
}
