//
//  ViewController.swift
//  GooglePlacesHit
//
//  Created by Appinventiv on 15/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var name:[String]=[]
    var address:[String]=[]
    var rating:[NSNumber]=[]
    var imageURLS:[String]=[]
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var query = ""
    fileprivate var key = "AIzaSyBXSZOOoR3kNLHEy1maOLnJzrUoGZRgAIM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.searchBar.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: --> Search Bar Delegates

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if self.tableView != nil{
            name.removeAll()
            rating.removeAll()
            address.removeAll()
            imageURLS.removeAll()
            tableView.isHidden = true
        }
        tableView.isHidden = false
        query = self.searchBar.text!
        self.fetchResponce(query)
        tableView.reloadData()
        noDataLabel.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}

extension ViewController{
    func fetchResponce(_ query:String){
        tableView.isHidden = false
        DispatchQueue.main.async {
            let spinner = UIViewController.displaySpinner(onView: self.view)
            APIController().login(query, self.key){(parameters) in
                self.name = parameters.name
                self.address = parameters.address
                self.rating = parameters.rating
                self.imageURLS = parameters.imageURLS
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.animate()
                    
                    if self.name.count == 0 && self.searchBar.text?.count == 0{
                        self.tableView.isHidden = true
                        self.noDataLabel.isHidden = false
                        self.noDataLabel.text = "Please enter a place to search !"
                    }
                    else if self.name.count == 0 && self.searchBar.text?.count != 0{
                        self.noDataLabel.isHidden = false
                        self.tableView.isHidden = true
                        self.noDataLabel.text = "INVALID SEARCH !!!"
                    }
                    
                }
                
                UIViewController.removeSpinner(spinner:spinner)
            }
        }
    }
}

//MARK: --> Table view data source methods

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributesTableViewCell") as! AttributesTableViewCell
        
        cell.nameLabel.text = self.name[indexPath.row]
        cell.ratingLabel.text = "\(String(describing: self.rating[indexPath.row]))"
        cell.vicinityLable.text = self.address[indexPath.row]
        
        let url = NSURL(string: imageURLS[indexPath.item])
        let data = NSData(contentsOf: url! as URL)
        cell.icon?.image = UIImage(data: data! as Data)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: --> Starting and stopping loader

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activity = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activity.startAnimating()
        activity.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(activity)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

//MARK: --> animations

extension ViewController{
    func animate(){
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.height
        for cell in cells
        {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells
        {
            UIView.animate(withDuration: 2, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .transitionCurlDown, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
