within IDEAS.Buildings.Components.Interfaces;
expandable connector WinBus "Linearized window bus"
  extends Modelica.Icons.SignalBus;

  parameter Integer nLay = 1 "Number of window layers";

  Real[nLay] AbsQFlow(start=fill(1,nLay));
  Real iSolDir(start=100);
  Real iSolDif(start=100);

  annotation (Documentation(revisions="<html>
<ul>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end WinBus;
