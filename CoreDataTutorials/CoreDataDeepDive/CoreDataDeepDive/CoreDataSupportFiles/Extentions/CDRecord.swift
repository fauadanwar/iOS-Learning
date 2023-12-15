//
//  CDRecord.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 04/12/23.
//

protocol CDRecord
{
    associatedtype T
    func convertToRecord() -> T
}
