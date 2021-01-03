enum TerrainFactor { PAVED_ROAD, GRAVEL_ROAD, WET_CLAY_OR_ICE, SAND, SWAMP }

class Terrain implements Comparable<Terrain> {
  final String name;
  final double factor;
  final TerrainFactor factorName;

  const Terrain(this.name, this.factor, this.factorName);

  static Terrain from(TerrainFactor factor) {
    Terrain terrain;
    switch (factor) {
      case TerrainFactor.PAVED_ROAD:
        terrain = Terrains.PAVED_ROAD;
        break;
      case TerrainFactor.GRAVEL_ROAD:
        terrain = Terrains.GRAVEL_ROAD;
        break;
      case TerrainFactor.WET_CLAY_OR_ICE:
        terrain = Terrains.WET_CLAY_OR_ICE;
        break;
      case TerrainFactor.SAND:
        terrain = Terrains.SAND;
        break;
      case TerrainFactor.SWAMP:
        terrain = Terrains.SWAMP;
        break;
    }
    return terrain;
  }

  @override
  int compareTo(Terrain other) => factor.compareTo(other.factor);

  @override
  String toString() => 'Terrain(name: $name, factor: $factor)';
}

class Terrains {
  static const Terrain PAVED_ROAD =
      Terrain('Paved Road', 1.0, TerrainFactor.PAVED_ROAD);
  static const Terrain GRAVEL_ROAD =
      Terrain('Gravel Road', 1.2, TerrainFactor.GRAVEL_ROAD);
  static const Terrain WET_CLAY_OR_ICE =
      Terrain('Wet Clay/Ice', 1.7, TerrainFactor.WET_CLAY_OR_ICE);
  static const Terrain SAND = Terrain('Sand', 2.0, TerrainFactor.SAND);
  static const Terrain SWAMP = Terrain('Swamp', 3.5, TerrainFactor.SWAMP);
}
