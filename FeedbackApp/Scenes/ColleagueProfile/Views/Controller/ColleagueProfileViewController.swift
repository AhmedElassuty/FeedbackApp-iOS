//
//  ColleagueProfileViewController.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

class ColleagueProfileViewController: BaseViewController {
    @IBOutlet weak var colleagueProfileTableView: UITableView!
    weak var colleagueProfileHeaderView         : ColleagueProfileTableHeader!

    var interactor  : ColleagueProfileBusinessLogic!
    var router      : ColleagueProfileRoutingLogic!
    var colleague   : ColleagueProfile.Colleague?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        fetchColleague()
    }
}

// MARK: - Colleague Profile Display View
extension ColleagueProfileViewController: ColleagueProfileDisplayView {
    func didFetchColleagueProfile(model: ColleagueProfile.Fetch.ViewModel) {
        colleague = model.colleague
        reloadData()
    }

    func failedToFetchColleagueProfile(error: ColleaguesUseCaseError) {
        switch error {
        case .fetchColleagueProfileError: break
        default: break
        }
    }
}

// MARK: - Table View Data Source
extension ColleagueProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let colleague = colleague,
            !colleague.feedbacks.isEmpty else {
            return 0
        }

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleague!.feedbacks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedback = colleague!.feedbacks[indexPath.row]
        let cell: ColleagueProfileFeedbackTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.prepareForUse(feedback: feedback)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Feedbacks"
    }
}

// MARK: - Private Methods
private extension ColleagueProfileViewController {
    func fetchColleague() {
        let request = ColleagueProfile.Fetch.Request()
        interactor.fetchColleagueProfile(request)
    }

    func prepareView() {
        prepareNavigationItems()
        prepareTableView()
    }

    func prepareNavigationItems() {
        title = "Profile"

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }

    func prepareTableView() {
        colleagueProfileTableView.estimatedRowHeight = 100
        colleagueProfileTableView.rowHeight = UITableViewAutomaticDimension

        colleagueProfileHeaderView = ColleagueProfileTableHeader()
        colleagueProfileTableView.tableHeaderView = colleagueProfileHeaderView

        colleagueProfileTableView.register(ColleagueProfileFeedbackTableViewCell.self)
    }

    func reloadData() {
        guard let colleague = colleague else {
            return
        }

        // Update header View
        colleagueProfileHeaderView.setColleague(
            name: colleague.name,
            imageURL: colleague.avatarURL
        )

        colleagueProfileTableView.reloadData()
        updateEmptyState(colleague: colleague)
    }

    func updateEmptyState(colleague: ColleagueProfile.Colleague) {
        guard colleague.feedbacks.isEmpty else {
            colleagueProfileTableView.backgroundView = nil
            return
        }

        let emptyView = EmptyFeedbacksView()
        emptyView.setData(colleague: colleague)
        colleagueProfileTableView.backgroundView = emptyView
    }
}
