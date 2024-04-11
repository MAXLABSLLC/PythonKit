
import Foundation
private let datetime = Python.import("datetime")

extension Date: PythonConvertible, ConvertibleFromPython {
    
    public init?(_ pythonObject: PythonObject) {
        let calendar = Calendar.current
        let compoments = DateComponents(
            calendar: calendar,
            year: Int(pythonObject.year),
            month: Int(pythonObject.month),
            day: Int(pythonObject.day),
            hour: Int(pythonObject.hour),
            minute: Int(pythonObject.minute),
            second: Int(pythonObject.second),
            nanosecond: Int(pythonObject.microsecond).flatMap({ $0 * 1000 })
        )
        guard let date = calendar.date(from: compoments) else {
            return nil
        }
        self = date
    }
    public var pythonObject: PythonObject {
        let comp = Calendar.current.dateComponents([
            .calendar, .timeZone,
            .year, .month, .day,
            .hour, .minute, .second, .nanosecond], from: self)
        return datetime.datetime(comp.year!, comp.month!, comp.day!,
                                   comp.hour!, comp.minute!, comp.second!, comp.nanosecond!/1_000)
    }
}
