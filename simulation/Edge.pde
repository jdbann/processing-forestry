class Edge {
  Node a, b;

  Edge(Node tempA, Node tempB) {
    a = tempA;
    b = tempB;
  }

  void tick(PGraphics pg) {
    pg.stroke(#00FFFF);
    pg.line(
      a.x * tileSize + tileSize / 2, 
      a.y * tileSize + tileSize / 2, 
      a.h * hScale + tileSize / 2, 
      b.x * tileSize + tileSize / 2, 
      b.y * tileSize + tileSize / 2, 
      b.h * hScale + tileSize / 2
      );
  }
}
