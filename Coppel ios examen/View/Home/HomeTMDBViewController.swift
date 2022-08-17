//
//  HomeTMDBViewController.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 16/08/22.
//

import UIKit

class HomeTMDBViewController: UIViewController{
    
    @IBOutlet weak var tmdbCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width / 2) - 8, height: 400)
        
        tmdbCollection.collectionViewLayout = layout
        tmdbCollection.delegate = self
        tmdbCollection.dataSource = self
        tmdbCollection.register(MovieShowViewCell.nib(), forCellWithReuseIdentifier: MovieShowViewCell.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        self.navigationController?.navigationBar.barTintColor  = UIColor.black
    }

}

extension HomeTMDBViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("selecccionado")
    }
}

extension HomeTMDBViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tmdbCollection.dequeueReusableCell(withReuseIdentifier: MovieShowViewCell.identifier, for: indexPath) as! MovieShowViewCell
        
        cell.imgLogo.image = UIImage(named: "https://pics.filmaffinity.com/Luca-907827591-large.jpg")
        cell.lblTitle.text = "Luca"
        cell.lblDate.text = "20 Agosto del 2022"
        cell.lblDescription.text = "Hola mundo de pruebas"
        
        return cell
    }
}

extension HomeTMDBViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
            return 3.0
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5.0
        }
}
