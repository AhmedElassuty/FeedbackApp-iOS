//
//  FetchColleagueProfileWorker.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
import FeedbackAppFileStore

protocol FetchColleagueProfileRequest {
    var userId: User.IdentifierType { get }
}

final class FetchColleagueProfileWorker {
    let fileStore: FeedbackAppFileStore.ColleaguesUseCase = ColleaguesUseCase()

    typealias ResultType = Result<User, ColleaguesUseCaseError>
    func fetchColleagueProfile(request: FetchColleagueProfileRequest,
        completion: (ResultType) -> Void) {
        fileStore.fetchColleagueProfile(id: request.userId) { storeResult in
            guard storeResult.isSuccess else {
                let error = ColleaguesUseCaseError(fileStoreError: storeResult.error!)
                let result = ResultType(error: error)
                completion(result)
                return
            }

            let result = ResultType(value: storeResult.value!)
            completion(result)
        }
    }
}
