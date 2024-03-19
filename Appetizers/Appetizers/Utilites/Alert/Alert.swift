//
//  Alert.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import SwiftUI
struct AlertItem{
    let title: String
    let message: Text
    let dissmissButton: Text
}
struct AlertContext {
    // MARK: - AppertizerList alert
    static let invalidURL       = AlertItem(title: "Server Error", message: Text("There was an issue connecting to the server. If this persists,                                please contact support."), dissmissButton: Text("OK"))
    
    static let invalidResponse  = AlertItem(title: "Server Error", message: Text("Invalid response from the server. Please try again later or contact                           support."), dissmissButton: Text("OK"))
    
    static let invalidData      = AlertItem(title: "Server Error", message: Text("The data received from the server was invalid. Please contact                                 support."), dissmissButton: Text("OK"))
    
    static let unableToComplete = AlertItem(title: "Server Error", message: Text("Unable to complete your request at this time. Please check your                               internet connection."), dissmissButton: Text("OK"))
    
    
    // MARK: - Account Alert
    static let invalidForm      = AlertItem(title: "Invalid Form", message: Text("Please ensure all fields in the form have been filled out."),                                 dissmissButton: Text("OK"))
    
    static let invalidEmail     = AlertItem(title: "Invalid Email", message: Text("Please ensure your email iis correct."), dissmissButton:                                     Text("OK"))
    
    static let userSavedSuccess = AlertItem(title: "Profile Saved", message: Text("Your profile information was successfully saved"), dissmissButton:                           Text("OK"))
    
    static let invalidUserData  = AlertItem(title: "Profile Error", message: Text("There was an error saving or retriving your profile."),                                      dissmissButton: Text("OK"))
}
