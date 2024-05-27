import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:helm_demo/constants/numeric/app_numeric.dart';

class CustomChipShape extends BodyComponent {
  final Vector2 conPosition;
  final String image;
  final double iWidth;
  // final List<Vector2> vertices;
  final double? scHeight;

  CustomChipShape({
    required this.conPosition,
    required this.image,
    required this.iWidth,
    // required this.vertices,
    this.scHeight,
  });

  double cusGravity = 5;
  Vector2 velocity = Vector2(0, 20);
  bool isBodyInitialized = false;
  double cornerRadius = 20;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;

    add(
      SpriteComponent(
        sprite: await Sprite.load(image),
        size: Vector2(iWidth, 50),
        anchor: Anchor.center,
      ),
    );
    isBodyInitialized = true;
  }

  @override
  Body createBody() {
    final shape = createShape();
    final fixtureDef = FixtureDef(
      shape,
      friction: 1,
      density: 1,
      restitution: 0,
    );
    final bodyDef = BodyDef(
      position: conPosition,
      type: BodyType.static,
    );
    var body = world.createBody(bodyDef)..createFixture(fixtureDef);

    return body;
  }

  PolygonShape createShape() {
    final double halfWidth = iWidth / 2;

    final double cornerRadiusClamped = cornerRadius.clamp(0, halfWidth);

    final List<Vector2> vertices = [
      Vector2(-halfWidth + cornerRadiusClamped,
          -AppNumericConts.chipHeight), // Bottom left
      Vector2(halfWidth - cornerRadiusClamped,
          -AppNumericConts.chipHeight), // Bottom right
      Vector2(
          halfWidth,
          -AppNumericConts.chipHeight +
              cornerRadiusClamped), // Bottom right corner
      Vector2(halfWidth,
          AppNumericConts.chipHeight - cornerRadiusClamped), // Top right corner
      Vector2(halfWidth - cornerRadiusClamped,
          AppNumericConts.chipHeight), // Top right
      Vector2(-halfWidth + cornerRadiusClamped,
          AppNumericConts.chipHeight), // Top left
      Vector2(-halfWidth,
          AppNumericConts.chipHeight - cornerRadiusClamped), // Top left corner
      Vector2(
          -halfWidth,
          -AppNumericConts.chipHeight +
              cornerRadiusClamped), // Bottom left corner
    ];

    final shape = PolygonShape()..set(vertices);
    return shape;
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocity.y += cusGravity;

    body.position.y += velocity.y * dt;

    if (body.position.y > (scHeight! * 0.70)) {
      Future.delayed(
        const Duration(microseconds: 200),
        () {
          velocity.y = 0;
          cusGravity = 0;
        },
      );
    }
  }
}
