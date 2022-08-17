//
//  DetailViewController.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 17/08/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTagLine: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblRunTime: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblVotes: UILabel!
    
    var detailObject : DetailObject?
    var detailViewModel : DetailVewModel!
    var tmdbID : Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel = DetailVewModel()
        callToViewModelForUIUpdate()
        detailViewModel.sendRequesDetail(id: tmdbID ?? 0)
        print(tmdbID ?? 0)
        
    }
    
    private func callToViewModelForUIUpdate(){
        self.detailViewModel.detailDataBinding = { [weak self]  in
            DispatchQueue.main.async {
                self?.detailObject = self?.detailViewModel.detailData
                self?.settupViews()
            }
        }
    }
    
    
   private func settupViews(){
       let poster = Constants.BASE_IMAGE + (detailObject?.backdropPath ?? "")
       let releaseDate = "Fecha de lanzamiento \n \(detailObject?.releaseDate ?? "")"
       let (h,m) = Utils.secondsToHoursMinutesSeconds(detailObject?.runtime ?? 0)
       
       imgPoster.makeRoundCorners(byRadius: 5)
       imgPoster.contentMode = . scaleAspectFill
       imgPoster.loadFrom(URLAddress: poster)
       lblTitle.text = detailObject?.title
       lblDescription.text = detailObject?.overview
       lblReleaseDate.text = releaseDate
       lblGenre.text = Utils.getGenres(genresList: detailObject?.genres ?? [])
       lblRunTime.text = "\(h)h \(m)m"
       lblTagLine.text = detailObject?.tagline
       lblVotes.text = "\(Utils.formatNumber(number: detailObject?.voteCount ?? 0)) votos"
       lblRate.text = "\(Utils.roundVote(voteAverage: detailObject?.voteAverage ?? 0.0))"
   }
    
    
    
}
