//
//  mainListTableViewController.swift
//  lifeStyle
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 syi. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import PMAlertController
import Alamofire
import SwiftyJSON
import SwiftRefresher
import Social


class mainListTableViewController: UITableViewController {

    let kCloseCellHeight: CGFloat = 195
    let kOpenCellHeight: CGFloat = 500
    let numberOfRow = 10
    var cellHeights = [CGFloat]()
    var menuView: BTNavigationDropdownMenu!
    var isLog: Bool = false
    var me:Person?
    var article = Article(){
        didSet(old){
            print("reload data")
            self.tableView.reloadData()
        }
    }
    var wbId = "4108895892911292"
    var token: String?
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = ["class one", "class two", "class three", "class four", "class five"]
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        var menuList = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "main class", items: items as [AnyObject])
        self.navigationItem.titleView = menuList
        menuList.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            self?.tableView.reloadData()
            
        }
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)

        
        menuList.cellHeight = 50
        menuList.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuList.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuList.shouldKeepSelectedCellColor = true
        menuList.cellTextLabelColor = UIColor.white
        menuList.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuList.cellTextLabelAlignment = .left
        menuList.arrowPadding = 15
        menuList.animationDuration = 0.5
        menuList.maskBackgroundColor = UIColor.black
        menuList.maskBackgroundOpacity = 0.3
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        createCellHeightsArray()
       self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bkgd")!)
        
        let refresher = Refresher{ [weak self] () -> Void in
           // self?.getAllArticle()
            self?.tableView.reloadData()
            self?.tableView.srf_endRefreshing()
            
        }
        tableView.srf_addRefresher(refresher)
        //self.tableView.backgroundColor = UIColor.red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllArticle()
        self.tableView.reloadData()
    }
    
    func createCellHeightsArray() {
        for _ in 0...numberOfRow {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
}

extension mainListTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num:Int
        if article.alAti.count != 0{
            num = article.alAti.count
            print(num)
            print("num not 0")
        }else{
            num = 0
            print("num 0")
        }
        return num
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as mainListTableViewCell = cell else {
            return
        }
        
        cell.backgroundColor = UIColor.clear
        
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainList", for: indexPath) as! mainListTableViewCell
        
        print("*&*&*&*&*")
        //**
        if article.alAti.count != 0{
            print("*&*&*&*&*")
            cell.author1.text = article.alAti[indexPath.row].author
            cell.author2.text = article.alAti[indexPath.row].author
            cell.intro1.text = article.alAti[indexPath.row].desc
            cell.intro2.text = article.alAti[indexPath.row].desc
            cell.title1.text = article.alAti[indexPath.row].title
            cell.title2.text = article.alAti[indexPath.row].title
            cell.img1.image = article.alAti[indexPath.row].image
            cell.img2.image = article.alAti[indexPath.row].image
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[(indexPath as NSIndexPath).row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! mainListTableViewCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight { // open cell
            cellHeights[(indexPath as NSIndexPath).row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[(indexPath as NSIndexPath).row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
        
    }
}





extension mainListTableViewController{
    
    @IBAction func pushStar(_ sender: UIButton) {
        let starAlert = PMAlertController(title: "STAR", description: "star this article", image: nil, style: PMAlertControllerStyle.walkthrough)
        
        starAlert.addTextField { (textfield) in
            textfield?.placeholder = "share your feelings......"
        }
        
        starAlert.addAction(PMAlertAction(title: "ok", style: PMAlertActionStyle.default, action: {()->Void in
            
            
        }))
        starAlert.addAction(PMAlertAction(title: "cancel", style: PMAlertActionStyle.cancel))
        self.present(starAlert, animated: true, completion: nil)
    }
    
    @IBAction func pushShare(_ sender: UIButton) {
        let shareAlert = PMAlertController(title: "SHARE", description: "", image: nil, style: PMAlertControllerStyle.walkthrough)
        
        shareAlert.addAction(PMAlertAction(title: "WeiChat", style: PMAlertActionStyle.default))
        shareAlert.addAction(PMAlertAction(title: "Weibo", style: PMAlertActionStyle.default,action:{()-> Void in
            let view = sender.superview
            let view1 = view?.superview
            let view2 = view1?.superview
            let view3 = view2?.superview
            let cell = view3?.superview as! UITableViewCell
           let indexpath = self.tableView.indexPath(for: cell)
            
            let sharePara = NSMutableDictionary()
            let a = self.article.alAti[(indexpath?.row)!]

            
            let vc = SSUIShareActionSheetController()
            
            let im = UIImage(named: "timg.jpeg")
            
            sharePara.ssdkSetupSinaWeiboShareParams(byText: "http://www.baidu.com \(a.desc)", title: "\(a.title)", image: im, url: nil, latitude: 0, longitude: 0, objectID: nil, type: SSDKContentType.auto)
            
            ShareSDK.share(SSDKPlatformType.typeSinaWeibo, parameters: sharePara, onStateChanged: { (_, _, _, error) in
                
                print("\(error)")
                
            })
            

        
        }))
        shareAlert.addAction(PMAlertAction(title: "cancel", style: PMAlertActionStyle.cancel))
        self.present(shareAlert, animated: true, completion: nil)
    }

    @IBAction func signIn(_ sender: UIButton) {
        if isLog{
            
            let i = me?.toImg(img: (me?.img)!)
            let selfInfo = PMAlertController(title: "Me", description: "\((me?.name)! as String)", image: i, style: PMAlertControllerStyle.walkthrough)
            selfInfo.addAction(PMAlertAction(title: "follower \(me!.description)", style: PMAlertActionStyle.default))
            selfInfo.addAction(PMAlertAction(title: "\((me?.location)! as String)", style: PMAlertActionStyle.default))
            selfInfo.addAction(PMAlertAction(title: "Sign out", style: PMAlertActionStyle.cancel, action: {
                self.isLog = false
            }))
            
            self.present(selfInfo, animated: true, completion: nil)
        }else{
            let signInAlert = PMAlertController(title: "SIGN IN", description: "", image: nil, style: PMAlertControllerStyle.walkthrough)
            
            signInAlert.addAction(PMAlertAction(title: "WeiChat", style: PMAlertActionStyle.default, action: {
                self.logIn(platform: SSDKPlatformType.typeWechat)
                
            }))
            signInAlert.addAction(PMAlertAction(title: "Weibo", style: PMAlertActionStyle.default,action:
                {
                    self.logIn(platform: SSDKPlatformType.typeSinaWeibo)
            }))
            signInAlert.addAction(PMAlertAction(title: "cancel", style: PMAlertActionStyle.cancel))
            self.present(signInAlert, animated: true, completion: nil)
            
        }
    }
    
    func logIn(platform: SSDKPlatformType){
        ShareSDK.getUserInfo(platform) { (responseState, user, error) in
            if responseState == SSDKResponseState.success{
                
                self.loginButton.titleLabel?.text = (user?.nickname!)!
                self.isLog = true
                let uid: String = (user?.uid!)!
                self.token = (user?.credential.token)!
               
                
                print(user?.icon)
            
                print("\(user?.credential.token!)")
                let parameters: [String: String] = ["access_token": (user?.credential.token)!]
                
            
                self.me = Person(name: (user?.nickname)!, img: (user?.icon)!, location: (user?.aboutMe)!, description: (user?.followerCount)!)
                
                self.getAllArticle()
                self.tableView.reloadData()
            }else{
                print("\(error)")
            }
        }
    }
    
}


extension mainListTableViewController{
    
    func getAllArticle(){
        if let tk = token{
            print("*******")
            
            article.getArticle(token: tk, id: wbId)
            
            print("######")
            print(article.alAti.count)
        }
        self.tableView.reloadData()

    }
    
    @IBAction func test(){
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! postViewController
        if let tk = self.token{
            des.token = tk
            des.isLog = isLog
            print(tk)
            print("aaaaa")
        }
        
        
    }
}

