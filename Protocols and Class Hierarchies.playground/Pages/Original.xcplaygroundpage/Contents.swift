import UIKit

class Shape {
    func draw(context: CGContext) {
        fatalError()
    }
    
    var boundingBox: CGRect {
        fatalError()
    }

    func image() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: boundingBox)
        return renderer.image { draw(context: $0.cgContext) }
    }
}

class Rectangle: Shape {
    var origin: CGPoint
    var size: CGSize
    var color: UIColor = .red
    
    init(origin: CGPoint, size: CGSize) {
        self.origin = origin
        self.size = size
    }
    
    override var boundingBox: CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    override func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.fill(boundingBox)
    }
}

class Circle: Shape {
    var center: CGPoint
    var radius: CGFloat
    var color: UIColor = .green
    
    init(center: CGPoint, radius: CGFloat) {
        self.center = center
        self.radius = radius
    }
    
    override var boundingBox: CGRect {
        return CGRect(origin: CGPoint(x: center.x-radius, y: center.y-radius), size: CGSize(width: radius*2, height: radius*2))
    }
    
    override func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: boundingBox)
    }
}

let size = CGSize(width: 100, height: 200)
let rectangle = Rectangle(origin: .zero, size: CGSize(width: 100, height: 200))
rectangle.image()

let circle: Shape = Circle(center: .zero, radius: 100)
circle.image()



