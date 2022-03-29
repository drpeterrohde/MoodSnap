import SwiftUI

extension ButterflyEntryStruct {
func influence() -> [CGFloat?] {
    // Averages
    var influenceAverageE: CGFloat? = nil
    var influenceAverageD: CGFloat? = nil
    var influenceAverageA: CGFloat? = nil
    var influenceAverageI: CGFloat? = nil
    
    if self.elevation.count > 0 && self.elevation[0] != nil && self.elevation[self.elevation.count-1] != nil {
        influenceAverageE = self.elevation[self.elevation.count-1]! - self.elevation[0]!
    }
    
    if self.depression.count > 0 && self.depression[0] != nil && self.depression[self.depression.count-1] != nil {
        influenceAverageD = self.depression[self.depression.count-1]! - self.depression[0]!
    }
    
    if self.anxiety.count > 0 && self.anxiety[0] != nil && self.anxiety[self.anxiety.count-1] != nil {
        influenceAverageA = self.anxiety[self.anxiety.count-1]! - self.anxiety[0]!
    }
    
    if self.irritability.count > 0 && self.irritability[0] != nil && self.irritability[self.irritability.count-1] != nil {
        influenceAverageI = self.irritability[self.irritability.count-1]! - self.irritability[0]!
    }
    
    // Volatilities
    var influenceVolatilityE: CGFloat? = nil
    var influenceVolatilityD: CGFloat? = nil
    var influenceVolatilityA: CGFloat? = nil
    var influenceVolatilityI: CGFloat? = nil
    
    if self.elevationVolatility.count > 0 && self.elevationVolatility[0] != nil && self.elevationVolatility[self.elevationVolatility.count-1] != nil {
        influenceVolatilityE = self.elevationVolatility[self.elevationVolatility.count-1]! - self.elevationVolatility[0]!
    }
    
    if self.depressionVolatility.count > 0 && self.depressionVolatility[0] != nil && self.depressionVolatility[self.depressionVolatility.count-1] != nil {
        influenceVolatilityD = self.depressionVolatility[self.depressionVolatility.count-1]! - self.depressionVolatility[0]!
    }
    
    if self.anxietyVolatility.count > 0 && self.anxietyVolatility[0] != nil && self.anxietyVolatility[self.anxietyVolatility.count-1] != nil {
        influenceVolatilityA = self.anxietyVolatility[self.anxietyVolatility.count-1]! - self.anxietyVolatility[0]!
    }
    
    if self.irritabilityVolatility.count > 0 && self.irritabilityVolatility[0] != nil && self.irritabilityVolatility[self.irritabilityVolatility.count-1] != nil {
        influenceVolatilityI = self.irritabilityVolatility[self.irritabilityVolatility.count-1]! - self.irritabilityVolatility[0]!
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
