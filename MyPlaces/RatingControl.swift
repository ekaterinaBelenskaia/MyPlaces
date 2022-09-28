//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Ekaterina on 27.09.22.
//

import UIKit

 @IBDesignable class RatingControl: UIStackView {
     
    // MARK: Properties
     
     var rating  = 0 {
         didSet {
             updateButtonSelectionState()
         }
     }
    
    private var ratingButtons = [UIButton]()
     @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
         didSet {
             setUpButtons()
         }
     }
     @IBInspectable var starCount: Int = 5 {
         didSet {
             setUpButtons()
         }
     }
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
    
    //MARK: Button action
    @objc func ratingButtonTapped(button: UIButton) {
        
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        
        // Calculate the rating of selected button
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }

    }
    
    // MARK: Private method
    
    private func setUpButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // Load button image
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar",
                                      in: bundle,
                                      compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            
        // create the button
        let button = UIButton()

        // Set the button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])

        // Add constraints
        button.translatesAutoresizingMaskIntoConstraints = false // отключает автоматически сгенерированные констрейнты для кнопки
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        // setup the button action
        button.addTarget(self, action: #selector(ratingButtonTapped(button: )), for: .touchUpInside)
        
        // add the button to the stack view
        addArrangedSubview(button)
        
            
        // Add the new button to the rating button array
            ratingButtons.append(button)
        }
        updateButtonSelectionState()
    }
     private func updateButtonSelectionState() {
         for (index, button) in ratingButtons.enumerated() {
             button.isSelected = index < rating
         }
     }

}
