//
//  MovieShowViewCell.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 16/08/22.
//

import UIKit

class MovieShowViewCell: UICollectionViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    static let identifier = "collectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "MovieShowViewCell", bundle: nil)
    }

}
