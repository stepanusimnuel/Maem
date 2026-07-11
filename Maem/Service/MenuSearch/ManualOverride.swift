//
//  ManualOverride.swift
//  Maem
//

import Foundation

/// Represents a manual UI choice that can override a text-parsed value,
/// distinct from "the user never touched this control." A plain `T?` can't
/// tell "unset" apart from "explicitly cleared" — this can.
enum ManualOverride<T: Equatable> {
    case unset
    case cleared
    case value(T)
}
