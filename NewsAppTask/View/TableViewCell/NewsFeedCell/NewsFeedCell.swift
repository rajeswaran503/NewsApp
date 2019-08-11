//
//  NewsFeedCell.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!

    static let cellID = "NEWS_CELL_ID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNewsFeedData(details:FeedDetails) {
        titleLabel.text = details.title
        descriptionLabel.text = details.description
        feedImageView.loadImageFromUrl(details.image ?? "", placeHolder: UIImage(named: "ImagePlaceHolder"))
        dateLabel.text = Date().getPastTime(for: details.date ?? "")
    }
    
}


