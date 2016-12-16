import UIKit

protocol Shape {
    func draw(context: CGContext)
    var boundingBox: CGRect { get }
    func rotated(by angle: CGFloat) -> Shape
}

extension Shape {
    func image() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: boundingBox)
        return renderer.image { draw(context: $0.cgContext) }
    }
    
    func rotated(by angle: CGFloat) -> Shape {
        return TransformedShape(original: self, transform: CGAffineTransform(rotationAngle: angle))
    }
}

struct TransformedShape {
    var original: Shape
    var transform: CGAffineTransform
}

extension TransformedShape: Shape {
    var boundingBox: CGRect {
        return original.boundingBox.applying(transform)
    }
    
    func draw(context: CGContext) {
        context.saveGState()
        context.concatenate(transform)
        original.draw(context: context)
        context.restoreGState()
    }
}

struct Rectangle: Shape {
    var origin: CGPoint
    var size: CGSize
    var color: UIColor = .red
    
    init(origin: CGPoint, size: CGSize) {
        self.origin = origin
        self.size = size
    }
    
    var boundingBox: CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.fill(boundingBox)
    }
}

struct Circle: Shape {
    var center: CGPoint
    var radius: CGFloat
    var color: UIColor = .green
    
    init(center: CGPoint, radius: CGFloat) {
        self.center = center
        self.radius = radius
    }
    
    var boundingBox: CGRect {
        return CGRect(origin: CGPoint(x: center.x-radius, y: center.y-radius), size: CGSize(width: radius*2, height: radius*2))
    }
    
    func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: boundingBox)
    }
}

let size = CGSize(width: 100, height: 200)
let rectangle = Rectangle(origin: .zero, size: CGSize(width: 100, height: 200))
rectangle.rotated(by: CGFloat(M_PI/6)).image()

let circle: Shape = Circle(center: .zero, radius: 100)
circle.rotated(by: CGFloat(M_PI)).image()



