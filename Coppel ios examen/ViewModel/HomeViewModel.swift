//
//  HomeViewModel.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 16/08/22.
//

import UIKit

class HomeViewModel: NSObject {
    private var apiService : APIService!
    var movieObject : MovieObject?
    
    var moviesDataBinding = {() -> () in }
    
    var moviesData : MovieObject? {
        didSet {
            moviesDataBinding()
        }
    }
        
    override init() {
        super .init()
        self.apiService = APIService()
        sendRequestGetPopular()
    }
    
    func sendRequestGetPopular(){
        self.apiService.sendRequestBillboardTMDB(endPointUrl: "movie/popular"){(result) in
            print(result)
            switch result {
            case .success(let data):
                self.parseMovie(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sendRequestGetTopRated(){
        self.apiService.sendRequestBillboardTMDB(endPointUrl: "movie/top_rated"){(result) in
            print(result)
            switch result {
            case .success(let data):
                self.parseMovie(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func sendRequestGetOnTheAir(){
        self.apiService.sendRequestBillboardTMDB(endPointUrl: "tv/on_the_air"){(result) in
            print(result)
            switch result {
            case .success(let data):
                self.parseShowTv(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func sendRequestGetAiringToday(){
        self.apiService.sendRequestBillboardTMDB(endPointUrl: "tv/airing_today"){(result) in
            print(result)
            switch result {
            case .success(let data):
                self.parseShowTv(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func parseMovie(jsonData: Data) {
        do {
            self.moviesData = try JSONDecoder().decode(MovieObject.self, from: jsonData)
        } catch {
            print("decode error")
        }
    }
    
    private func parseShowTv(jsonData: Data) {
        do {
            let movie = try JSONDecoder().decode(ShowTvObject.self, from: jsonData)
            print(movie)
        } catch {
            print("decode error")
        }
    }
}
