//
//  ViewController.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var previewImage1: UIImageView!
    @IBOutlet weak var previewImage2: UIImageView!
    @IBOutlet weak var previewImage3: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var previewImagesHeight: NSLayoutConstraint!
    
    @IBOutlet var previewImages: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let previewHeight = (view.frame.width - 60)/3
        previewImagesHeight.constant = previewHeight
        
        for preview in previewImages{
            setPreviewImage(imageView: preview, height: previewHeight)
        }
        
        
        
    }
    
    func setPreviewImage(imageView: UIImageView, height: CGFloat) {
        
        let colors: [UIColor] = [.red, .blue, .cyan, .purple, .yellow, .brown]
        
        imageView.layer.cornerRadius = height/2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = colors.randomElement()?.cgColor
        
    }
    
    

    @IBAction func touchPlayButton(_ sender: UIButton) {
        
        for preview in previewImages {
            preview.image = UIImage(named: "poster-\(Int.random(in: 1...20))")
        }
        backgroundImageView.image = UIImage(named: "poster-\(Int.random(in: 1...20))")
        
    }
    
}

