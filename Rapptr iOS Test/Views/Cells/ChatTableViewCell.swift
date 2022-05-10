//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var chatBubbleView: UIView!
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.clipsToBounds = true
        chatBubbleView.layer.cornerRadius = 8
        chatBubbleView.layer.borderColor = UIColor.chatBubbleBackground?.cgColor
        chatBubbleView.layer.borderWidth = 1
        selectionStyle = .none
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.name
        body.text = message.message
        fetchAvatarImage(message: message)
    }
    
    func fetchAvatarImage(message: Message) {
        ChatClient.fetchImage(with: message.avatar_url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedImage):
                    self.avatarImageView.image = fetchedImage
                case .failure(let error):
                    if #available(iOS 13.0, *) {
                        self.avatarImageView.image = UIImage(systemName: "person")
                    } else {
                        // Fallback on earlier versions
                    }
                    print("Error loading image: \(error)")
                }
            }
        }
    }
}
