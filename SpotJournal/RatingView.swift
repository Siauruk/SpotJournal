//
//  RatingView.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/12/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit

@IBDesignable class RatingView: UIStackView {
    
    // Mark: Properties
    
    var rating = 0 {
        didSet {
            setupImageViews()
        }
    }
    
    private var ratingImageViews: [UIImageView] = []
    
    @IBInspectable var starSize: CGSize = CGSize.init(width: 15.0, height: 15.0) {
        didSet {
            setupImageViews()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupImageViews()
        }
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupImageViews()
    }
    
    // MARK: Private Methods
    
    private func setupImageViews() {
        
        // Remove old imageViews from Storyboard
        ratingImageViews.forEach { imageView in
            removeArrangedSubview(imageView)
            imageView.removeFromSuperview()
        }
        
        // Remove old imageViews from array for Storyboard
        ratingImageViews.removeAll()
        
        // Load image for imageView
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        // Create starCount imageViews
        for starIndex in 0..<starCount {
            
            // Create the imageView
            let imageView = UIImageView()
            
            // Set the image to imageView
            if starIndex < rating {
                imageView.image = filledStar
            } else {
                imageView.image = emptyStar
            }
            
            // Add constraints
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            
            // Add the imageView to the stack
            addArrangedSubview(imageView)
            
            // Add the new imageView to the rating imageView array
            ratingImageViews.append(imageView)
        }
    }
}

