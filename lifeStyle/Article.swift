//
//  Article.swift
//  lifeStyle
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 syi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Article {
    var author: String = ""
    var title: String = ""
    var desc: String = ""
    var type: String = ""
    var image: UIImage = UIImage()
    var alAti = [Article]()
    
    init() {
        author = ""
        title = ""
        desc = ""
        type = ""
        image = UIImage()
    }

    init(title: String, desc: String, type: String, author: String, image: UIImage) {
        self.title = title
        self.desc = desc
        self.type = type
        self.author = author
        self.image = image
    }
    
    func getArticle(token: String,id: String){
        alAti.removeAll()
        func spltText(text:String) -> [String] {
            let spedText = text.components(separatedBy: "&")
            return spedText
        }
        
            Alamofire.request("https://api.weibo.com/2/comments/show.json",method: .get, parameters: ["access_token": token, "id": id], encoding: URLEncoding.default).responseJSON(completionHandler: { (response) in
                let json = JSON(data: response.data!)
                print("*******comment")
                let allInfo = json["comments"]
                var articles = [Article]()
                
                
                for i in 0..<allInfo.count{
                    let a = allInfo[i]
                    let splttext = "\(a["text"])"
                    let spedtext = spltText(text: splttext)
                    let author = a["user"]["name"]
                    print("************\(spedtext)***\(author)***\(a["user"]["avatar_large"])")
                    let url = URL(string: "\(a["user"]["avatar_large"])")
                    let data = NSData(contentsOf: url!)
                    let image = UIImage(data: data! as Data)
                    
                    let article = Article(title: "\(spedtext[0])", desc: "\(spedtext[2])", type: "\(spedtext[2])", author: "\(author)", image: image!)
                    
                    self.alAti.append(article)
                }
            })
    }
    
    }

