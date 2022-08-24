//
//  NewsTableVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class NewsTableVC: UITableViewController {
    @IBOutlet weak var foneImageView: UIImageView!
    
    private var news = NewsStorage.shared
    private var height: CGFloat = 230

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        configuration()
    }
    
    private func configuration() {
        foneImageView.layer.cornerRadius = 10
        
        // registration of nib
        tableView.register(UINib(nibName: "NewsTVCell", bundle: nil), forCellReuseIdentifier: "newsCell")
    }
    
    private func toFollowUsScreen() {
        let storyboard = UIStoryboard(name: "FollowUs", bundle: nil)
        let followUsScreen = storyboard.instantiateViewController(withIdentifier: Screens.followUs.rawValue)
        present(followUsScreen, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTVCell
        newsCell.configure(news.elements[indexPath.row])
        newsCell.selectionStyle = .none
        return newsCell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = news.elements[indexPath.row].title
        switch cell.lowercased() {
        case "follow us":
            toFollowUsScreen()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotation = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.contentView.layer.transform = rotation

        UIView.animate(withDuration: 0.7) {
            cell.contentView.layer.transform = CATransform3DIdentity
        }
    }
}
