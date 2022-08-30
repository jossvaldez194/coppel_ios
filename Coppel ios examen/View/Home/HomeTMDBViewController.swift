//
//  HomeTMDBViewController.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 16/08/22.
//

import UIKit

class HomeTMDBViewController: UIViewController{
    
    @IBOutlet weak var tmdbCollection: UICollectionView!
    private var homeViewModel : HomeViewModel!
    
    var moviesObject : MovieObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeViewModel =  HomeViewModel()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width / 2) - 15, height: 400)
        tmdbCollection.collectionViewLayout = layout
        tmdbCollection.delegate = self
        tmdbCollection.dataSource = self
        tmdbCollection.register(MovieShowViewCell.nib(), forCellWithReuseIdentifier: MovieShowViewCell.identifier)
        callToViewModelForUIUpdate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor  = UIColor.black
    }
    
    override func viewWillLayoutSubviews() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
                //set image for button
        button.setImage(UIImage(named: "menu.png"), for: UIControl.State.normal)
                //add function for button
        button.addTarget(self, action: #selector(barButtonAction), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)

        let barButton = UIBarButtonItem(customView: button)
                //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    @objc func barButtonAction() {
        showPopUp()
            
    }
    
    func callToViewModelForUIUpdate(){
        self.homeViewModel.moviesDataBinding = { [weak self]  in
            DispatchQueue.main.async {
                self?.moviesObject = self?.homeViewModel.moviesData
                self?.tmdbCollection.reloadData()
            }
        }
    }
    
    private func showPopUp(){
        let alertController = UIAlertController(title: "What do you what to do?", message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        let somethingAction = UIAlertAction(title: "Profile", style: .default, handler: {(alert: UIAlertAction!) in let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profile") as? ProfileViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        })
        
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
            
            UserPreferences.deleteAll()
            
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})

        alertController.addAction(somethingAction)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:{})
        }
    }

}

extension HomeTMDBViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detail") as? DetailViewController
        vc?.tmdbID = moviesObject?.results[indexPath.row].id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension HomeTMDBViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesObject?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tmdbCollection.dequeueReusableCell(withReuseIdentifier: MovieShowViewCell.identifier, for: indexPath) as! MovieShowViewCell
        
        cell.imgLogo.loadFrom(URLAddress: Constants.BASE_IMAGE + (moviesObject?.results[indexPath.row].posterPath ?? ""))
        cell.lblTitle.text = moviesObject?.results[indexPath.row].title
        cell.lblDate.text = moviesObject?.results[indexPath.row].releaseDate
        cell.lblDescription.text = moviesObject?.results[indexPath.row].overview
        cell.lblRate.text = Utils.roundVote(voteAverage: moviesObject?.results[indexPath.row].voteAverage ?? 0.0)
        
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


