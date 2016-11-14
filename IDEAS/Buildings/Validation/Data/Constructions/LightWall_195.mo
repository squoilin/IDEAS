within IDEAS.Buildings.Validation.Data.Constructions;
record LightWall_195 "BESTEST Light wall"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final nLay=3,
    final mats={
        IDEAS.Buildings.Validation.Data.Materials.WoodSiding_195(d=0.009),
        IDEAS.Buildings.Validation.Data.Insulation.FiberGlass(d=0.066),
        IDEAS.Buildings.Validation.Data.Materials.PlasterBoard(d=0.012)});

end LightWall_195;
