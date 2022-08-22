//
//  NewsTableVC.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

class NewsTableVC: UITableViewController {
    @IBOutlet weak var foneImageView: UIImageView!
//    @IBOutlet weak var newsTableView: UITableView!
    
    private var singleton = NewsStorage.shared
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
        return singleton.title!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTVCell
        newsCell.titleLabel.text = singleton.title![indexPath.row]
        newsCell.dateLabel.text = singleton.date![indexPath.row]
        newsCell.descriptionLabel.text = singleton.description![indexPath.row]
        newsCell.imageImageView.image = singleton.images![indexPath.row]
        newsCell.selectionStyle = .none
        return newsCell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = singleton.title?[indexPath.row]
        switch cell?.lowercased() {
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
