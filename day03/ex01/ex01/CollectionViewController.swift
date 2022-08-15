//
//  ViewController.swift
//  ex00
//
//  Created by Андрей Мотырев on 01.08.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    @IBOutlet var imageCollectionView: UICollectionView!
    
    let imagesArr : [URL] = [
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/florence.jpeg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/45025340661_7b9f8f9402_k.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/8.22-396o5017lane.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/43656168861_3c30e55b14_o.jpg")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        let imgUrl = imagesArr[indexPath.row]
        DispatchQueue.global().async {
            let imgData = try? Data(contentsOf: imgUrl)
            if imgData == nil {
                
                let alert = UIAlertController(title: "Error", message: "Can not acces link", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    cell.loader.hidesWhenStopped = true
                    cell.loader.stopAnimating()
                    cell.imageView.image = UIImage(data: imgData!)
                }
            }
        }
        
        cell.loader.startAnimating()
        cell.loader.color = (UIColor.white)
        cell.layer.borderColor = (UIColor.black.cgColor)
        cell.layer.backgroundColor = (UIColor.black.cgColor)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        // Configure the cell
    
        return cell
    }

}
