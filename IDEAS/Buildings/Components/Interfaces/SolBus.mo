within IDEAS.Buildings.Components.Interfaces;
expandable connector SolBus
  "Bus containing solar radiation for various incidence angles"
  extends Modelica.Icons.SignalBus;

  Real iSolDir(start=100);
  Real iSolDif(start=100);

  Modelica.SIunits.Angle angZen;
  Modelica.SIunits.Angle angAzi;
  Modelica.SIunits.Angle angInc;

  Modelica.SIunits.Temperature Tenv(start=293.15);
end SolBus;
