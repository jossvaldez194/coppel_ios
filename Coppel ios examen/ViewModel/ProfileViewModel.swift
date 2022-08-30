//
//  ProfileViewModel.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 17/08/22.
//

import UIKit

class ProfileViewModel: NSObject {
    
    private var apiService : APIService!
    
    var profileDataBinding = {() -> () in }
    
    var profileData : ProfileObject? {
        didSet {
            profileDataBinding()
        }
    }
    
    override init() {
        super .init()
        apiService = APIService()
        sendRequestGetProfile()
    }
    
    
    func sendRequestGetProfile(){
        self.apiService.sendRequestProfile{(result) in
            print(result)
            switch result {
            case .success(let data):
                self.parseJson(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseJson(jsonData: Data) {
        do {
            self.profileData = try JSONDecoder().decode(ProfileObject?.self, from: jsonData)
        } catch {
            print("decode error")
        }
    }


}
