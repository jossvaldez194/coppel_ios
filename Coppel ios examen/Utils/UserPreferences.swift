//
//  UserPreferences.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 17/08/22.
//

import UIKit

class UserPreferences {
    
    static func saveToken(token : String){
        UserDefaults.standard.set(token, forKey: "userToken")
    }
    
    static func retrieveToken() -> String{
        return UserDefaults.standard.string(forKey: "userToken") ?? ""
    }
    
    
    static func saveSession(session : String){
        UserDefaults.standard.set(session, forKey: "userSession")
    }
    
    static func retrieveSession() -> String{
        return UserDefaults.standard.string(forKey: "userSession") ?? ""
    }
    
    
    static func deleteAll(){
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
    }


}
