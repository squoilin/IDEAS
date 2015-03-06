within IDEAS.Buildings.Components.Interfaces;
expandable connector WinBus "Linearized window bus"
  extends Modelica.Icons.SignalBus;

  parameter Integer nLay = 1 "Number of window layers";

  Real[nLay] AbsQFlow;
  Real iSolDir;
  Real iSolDif;

end WinBus;
