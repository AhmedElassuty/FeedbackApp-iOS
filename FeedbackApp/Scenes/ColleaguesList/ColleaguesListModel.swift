//
//  ColleaguesListModel.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

struct ColleaguesList {
    struct Colleague: Identifiable, Equatable {
        let id                      : Int
        let name                    : String
        let lastFeedbackDateCategory: Theme.DateCategory?
        let lastFeedbackDateString  : String?
        let avatarURL               : URL?
    }
}

extension ColleaguesList {
    enum GiveFeedback {}
}

extension ColleaguesList.GiveFeedback {
    typealias Request   = GiveColleagueFeedbackRequest

    typealias Response  = Result<User, ColleaguesUseCaseError>

    struct ViewModel {
        let colleague: ColleaguesList.Colleague
    }
}

extension ColleaguesList {
    enum Fetch {}
}

extension ColleaguesList.Fetch {
    typealias Request   = FetchColleaguesRequest

    typealias Response  = Result<[User], ColleaguesUseCaseError>

    struct ViewModel {
        let colleagues: [[ColleaguesList.Colleague]]
    }
}
