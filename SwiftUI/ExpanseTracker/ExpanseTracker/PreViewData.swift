//
//  PreViewData.swift
//  ExpanseTracker
//
//  Created by mac on 29/04/24.
//

import Foundation

var transcationPreviewData = Transaction(id: 1, date: "04/09/2022", institution: "Unikwork", account: "Visa Unikwork", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: true, isExpense: true, isEdited: false)

var TranscationList = [Transaction](repeating: transcationPreviewData, count: 10)
