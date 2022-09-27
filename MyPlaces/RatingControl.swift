//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Ekaterina on 27.09.22.
//

import UIKit

 @IBDesignable class RatingControl: UIStackView {
     
    // MARK: Properties
    
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
    var rating  = 0
    
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
        print ("Button pressed!")
    }
    
    // MARK: Private method
    
    private func setUpButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            
        // create the button
        let button = UIButton()
        button.backgroundColor = .red
        
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
    }

}
