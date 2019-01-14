//
//  Extensions.swift
//  dogAPI_Test
//
//  Created by admin on 1/14/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

extension UIView {
    
    func safeFullScreen(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        self.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        self.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        self.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
    }
    
    func anchorC(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,  paddingTop: CGFloat = 0, paddingLeading: CGFloat = 0, paddingBottom: CGFloat = 0, paddingTrailing: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?){
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing).isActive = true
        }
    }
    
}
