//
//  ImageViewController.swift
//  Cassini
//
//  Created by Andriy Krupych on 4/26/17.
//  Copyright © 2017 Andriy Krupych. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var image: String?
    fileprivate var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 100
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let image = self.image, let imageURL = URL(string: image) {
            fetchImage(withUrl: imageURL)
        }
    }
    
    private func fetchImage(withUrl url: URL) {
        spinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if  let imageData = try? Data(contentsOf: url),
                let currentImage = self?.image,
                let currentURL = URL(string: currentImage) {
                if currentURL == url {
                    DispatchQueue.main.async {
                        self?.spinner.stopAnimating()
                        self?.updateImageView(imageData: imageData)
                    }
                }
            }
        }
    }
    
    private func updateImageView(imageData: Data) {
        imageView.image = UIImage(data: imageData)
        imageView.sizeToFit()
        scrollView.contentSize = imageView.frame.size
    }

}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
