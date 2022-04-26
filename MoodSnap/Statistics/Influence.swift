import SwiftUI

/**
 Extension to convert transient to infuence.
 */
extension ButterflyEntryStruct {
    func influence() -> [CGFloat?] {
        // Averages
        var influenceAverageE: CGFloat? = nil
        var influenceAverageD: CGFloat? = nil
        var influenceAverageA: CGFloat? = nil
        var influenceAverageI: CGFloat? = nil

        if elevation.count > 0 && elevation[0] != nil && elevation[elevation.count - 1] != nil {
            influenceAverageE = elevation[elevation.count - 1]! - elevation[0]!
        }

        if depression.count > 0 && depression[0] != nil && depression[depression.count - 1] != nil {
            influenceAverageD = depression[depression.count - 1]! - depression[0]!
        }

        if anxiety.count > 0 && anxiety[0] != nil && anxiety[anxiety.count - 1] != nil {
            influenceAverageA = anxiety[anxiety.count - 1]! - anxiety[0]!
        }

        if irritability.count > 0 && irritability[0] != nil && irritability[irritability.count - 1] != nil {
            influenceAverageI = irritability[irritability.count - 1]! - irritability[0]!
        }

        // Volatilities
        var influenceVolatilityE: CGFloat? = nil
        var influenceVolatilityD: CGFloat? = nil
        var influenceVolatilityA: CGFloat? = nil
        var influenceVolatilityI: CGFloat? = nil

        if elevationVolatility.count > 0 && elevationVolatility[0] != nil && elevationVolatility[elevationVolatility.count - 1] != nil {
            influenceVolatilityE = elevationVolatility[elevationVolatility.count - 1]! - elevationVolatility[0]!
        }

        if depressionVolatility.count > 0 && depressionVolatility[0] != nil && depressionVolatility[depressionVolatility.count - 1] != nil {
            influenceVolatilityD = depressionVolatility[depressionVolatility.count - 1]! - depressionVolatility[0]!
        }

        if anxietyVolatility.count > 0 && anxietyVolatility[0] != nil && anxietyVolatility[anxietyVolatility.count - 1] != nil {
            influenceVolatilityA = anxietyVolatility[anxietyVolatility.count - 1]! - anxietyVolatility[0]!
        }

        if irritabilityVolatility.count > 0 && irritabilityVolatility[0] != nil && irritabilityVolatility[irritabilityVolatility.count - 1] != nil {
            influenceVolatilityI = irritabilityVolatility[irritabilityVolatility.count - 1]! - irritabilityVolatility[0]!
        }

        let results = [influenceAverageE,
                       influenceAverageD,
                       influenceAverageA,
                       influenceAverageI,
                       influenceVolatilityE,
                       influenceVolatilityD,
                       influenceVolatilityA,
                       influenceVolatilityI]

        return results
    }
}
