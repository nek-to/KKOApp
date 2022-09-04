//
//  NewsTableVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

enum Storyboards: String {
    case follow = "FollowUs"
    case animation = "AnimationNews"
    case protection = "Protection"
    case map = "MapNews"
}

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
        
        // registration for nib
        tableView.register(UINib(nibName: "NewsTVCell", bundle: nil), forCellReuseIdentifier: "newsCell")
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
        let cell = news.elements[indexPath.row]
        var screen = UIViewController()
        switch cell.id {
        case 0:
            screen = UIStoryboard(name: Storyboards.follow.rawValue, bundle: nil).instantiateViewController(withIdentifier: Screens.followUs.rawValue)
        case 1:
            screen = UIStoryboard(name: Storyboards.animation.rawValue, bundle: nil).instantiateViewController(withIdentifier: Screens.animation.rawValue)
        case 2:
            screen = UIStoryboard(name: Storyboards.protection.rawValue, bundle: nil).instantiateViewController(withIdentifier: Screens.protection.rawValue)
        case 3:
            screen = UIStoryboard(name: Storyboards.map.rawValue, bundle: nil).instantiateViewController(withIdentifier: Screens.mapNews.rawValue)
        default:
            break
        }
        present(screen, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotation = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.contentView.layer.transform = rotation

        UIView.animate(withDuration: 0.7) {
            cell.contentView.layer.transform = CATransform3DIdentity
        }
    }
}
