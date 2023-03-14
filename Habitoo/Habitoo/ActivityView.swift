//
//  ActivityView.swift
//  Habitoo
//
//  Created by Leon Grimmeisen on 25.03.22.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var data: Activities
    var activity: Activity
    
    var body: some View {
        List {
            Section {
                if activity.description.isEmpty == false {
                    Text(activity.description)
                }
            }
            
            Section {
                Text("Completion count: \(activity.completionCount)")
                
                Button("Mark Completed") {
                /// creat a new activity and add 1 to completion count, then replace the old activity with new one
                    var newActivity = activity
                    newActivity.completionCount += 1
                    
                    if let index = data.activities.firstIndex(of: activity) {
                        data.activities[index] = newActivity
                    }
                }
            }
        }
        .navigationTitle(activity.title)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(data: Activities(), activity: Activity.example)
    }
}
