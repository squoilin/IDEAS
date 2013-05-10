within IDEAS.Buildings.Validation.Cases;
model Case900
  extends IDEAS.Buildings.Validation.Interfaces.BesTestCase(
    redeclare BaseClasses.Structure.Bui900 building,
    redeclare BaseClasses.Occupant.Gain occupant,
    redeclare BaseClasses.HeatingSystem.Deadband heatingSystem,
    redeclare BaseClasses.VentilationSystem.None ventilationSystem,
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder
                                                inHomeGrid);
end Case900;
