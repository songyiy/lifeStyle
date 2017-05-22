//
//  Person.swift
//  lifeStyle
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 syi. All rights reserved.
//

import Foundation

class Person{
    var name: String
    var img: String
    var location: String
    var description: Int
    
    init(name: String, img: String, location: String, description: Int) {
        self.name = name
        self.img = img
        self.location = location
        self.description = description
    }
    
    func toImg(img:String)->UIImage{
        
        print("++++\(img)")
        
        let url = URL(string: img)
        let data = NSData(contentsOf: url!)
        let image = UIImage(data: data! as Data)
        
        return image!
    }
}
