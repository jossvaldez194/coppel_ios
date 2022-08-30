//
//  LoginViewModel.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 12/08/22.
//

import Foundation

class LoginViewModel : NSObject{
    
    private var apiService : APIService!
    
    var userTokenValue : TokenTMDB! {
        didSet {
            self.tokenDataBind()
        }
    }
    
    var success : String? {
        didSet {
            self.successDataBind()
        }
    }
    
    var tokenDataBind = {() -> () in }
    var successDataBind = {() -> () in }
    
    override init() {
        super .init()
        self.apiService = APIService()
        sendRequestCreateToken()
    }
    
    func sendRequestCreateToken(){
        self.apiService.generateToken{(result) in
            print(result)
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
                //self.sendRequestMakeLogin(user: user, pasw: pasw, token: self.userSession.request_token)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func sendRequestCreateSession(user: String, pasw : String){
        if(UserPreferences.retrieveSession().isEmpty){
            if(!user.isEmpty || !pasw.isEmpty){
                self.apiService.generateSession(token: userTokenValue.request_token){(result) in
                    switch result {
                    case .success(let data):
                        self.parseSession(jsonData: data, user: user, pass: pasw)
                    case .failure(_):
                        print("hola")
                    }
                }
            }else{
                self.success = "fail"
            }
        }else{
            sendRequestMakeLogin(user: user, pasw: pasw, token: userTokenValue.request_token)
        }
        
    }

    private func sendRequestMakeLogin(user: String, pasw : String, token : String){
        self.apiService.sendRequestToLogin(user: user, passwd: pasw, token: token, completion: {(result) in
            print(result)
            switch result {
            case .success(_):
                self.success = ""
            case .failure(_):
                self.success = "fail"
                
            }
        })
    }
    
    private func parse(jsonData: Data) {
        do {
            userTokenValue = try JSONDecoder().decode(TokenTMDB.self, from: jsonData)
            if userTokenValue != nil{
                UserPreferences.saveToken(token: userTokenValue.request_token)
                //self.success = ""
            }
        } catch {
            print("decode error")
        }
    }
    
    private func parseSession(jsonData: Data, user : String, pass : String) {
        do {
            let userSessionValue = try JSONDecoder().decode(SessionResponse.self, from: jsonData)
            UserPreferences.saveSession(session: userSessionValue.session_id)
            let token = UserPreferences.retrieveToken()
            sendRequestMakeLogin(user: user, pasw: pass, token: token)
        } catch {
            success = "fail"
        }
    }
    
}
