//
//  postViewController.swift
//  lifeStyle
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 syi. All rights reserved.
//

import UIKit
import SwiftForms
import Alamofire
import PMAlertController

class postViewController: ViewController {

    @IBOutlet weak var dView: UIView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var textview: UITextView!
    var token: String?
    var isLog:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()

        postButton.layer.cornerRadius = 10
        postButton.layer.masksToBounds = true
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        dView.layer.cornerRadius = 10
        dView.layer.masksToBounds = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkgd")!)

      print("\(token)")
        

        
       // former.append(sectionFormer: section2)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postArticle(_ sender: UIButton) {
        if let token1 = token{
            let url = "https://api.weibo.com/2/comments/create.json"
            let wbid = "4108895892911292"
            let intid = Int(wbid)
            let article = textview.text
            let para = ["access_token": token1, "comment": article!, "id": wbid]
            self.navigationController?.popViewController(animated: true)
            Alamofire.request(url, method: .post, parameters: para, encoding: URLEncoding.default).responseJSON { (res) in
            print(res.result)
            }
            
        }else{
            let aAlert = PMAlertController(title: "", description: "PLEASE LOGIN", image: nil, style: PMAlertControllerStyle.walkthrough)
            
            aAlert.addAction(PMAlertAction(title: "OK", style: PMAlertActionStyle.cancel))
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
