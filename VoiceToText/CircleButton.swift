//
//  CircleButton.swift
//  VoiceToText
//
//  Created by Roger on 1/25/17.
//  Copyright © 2017 Yashwanth. All rights reserved.
//

import UIKit
@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 30.0{
        
        didSet{
            setUpView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView(){
        layer.cornerRadius = cornerRadius;

    }
    

}
