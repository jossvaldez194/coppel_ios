//
//  DetailVewModel.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 17/08/22.
//

import UIKit

class DetailVewModel: NSObject {
    private var apiService : APIService!
    
    
    var detailObject : DetailObject?
    
    var detailDataBinding = {() -> () in }
    
    var detailData : DetailObject? {
        didSet {
            detailDataBinding()
        }
    }
        
    override init() {
        super .init()
        self.apiService = APIService()
    }
    
    func sendRequesDetail(id : Int){

        self.apiService.sendRequestDetail(id: String(id)){(result) in
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
            self.detailData = try JSONDecoder().decode(DetailObject.self, from: jsonData)
        } catch {
            print("decode error")
        }
    }

}
