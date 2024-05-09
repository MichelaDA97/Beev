//
//  CloudKitUser.swift
//  Beev
//
//  Created by Chiara Cangelosi on 09/05/24.
//

import SwiftUI
import CloudKit

class CloudKitUserViewModel: ObservableObject
{
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    
    init()
    {
        getiCloudStatus()
    }
    
    private func getiCloudStatus()
    {
        CKContainer.default().accountStatus
        {
            [weak self] returnedStatus, returnedError in DispatchQueue.main.async
            {
                switch returnedStatus
                {
                    case .available:
                        self?.isSignedInToiCloud = true
                    case .noAccount:
                        self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                    case .couldNotDetermine:
                        self?.error = CloudKitError.iCloudAccountNotDetermined.localizedDescription
                    case .restricted:
                        self?.error = CloudKitError.iCloudAccountRestricted.localizedDescription
                    @unknown default:
                        self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                }
            }
        }
    }
}

enum CloudKitError: String,  LocalizedError
{
    case iCloudAccountNotFound
    case iCloudAccountNotDetermined
    case iCloudAccountRestricted
    case iCloudAccountUnknown
}

//func discoveriCloudUser(id: CKRecord.ID)

struct CloudKitUser: View
{
    @StateObject private var vm = CloudKitUserViewModel()
    var body: some View
    {
        VStack
        {
            Text("is Signed in: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
        }
    }
}

#Preview {
    CloudKitUser()
}
