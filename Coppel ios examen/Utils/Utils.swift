//
//  Utils.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 17/08/22.
//

import UIKit

class Utils {
    
    static func getGenres(genresList : [Genre]) -> String {
        var genres = String()
        for gen in genresList{
            if genres.isEmpty{
                genres = gen.name
            }else{
                genres = genres + ", \(gen.name)"
            }
            
        }
        
        return genres
    }
    
    static func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func roundVote(voteAverage : Double) -> String {
       return String(format: "%.1f", voteAverage)
    }
    
    static func formatNumber(number : Int) -> String{
        var numberFormat = String()
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .decimal
        if let formattedTipAmount = formatter.string(from: number as NSNumber) {
            numberFormat = "\(formattedTipAmount)"
        }
        
        return numberFormat
    }
}
