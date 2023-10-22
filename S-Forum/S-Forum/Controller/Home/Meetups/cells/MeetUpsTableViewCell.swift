//
//  MeetUpsTableViewCell.swift
//  S-Forum
//
//  Created by Fakunabs on 21/10/2023.
//

import UIKit

class MeetUpsTableViewCell: UITableViewCell {

    @IBOutlet private weak var scheduleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        scheduleView.layer.cornerRadius = 5
    }
}
