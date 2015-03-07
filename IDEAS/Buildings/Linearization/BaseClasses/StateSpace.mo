within IDEAS.Buildings.Linearization.BaseClasses;
model StateSpace "State space model with bus inputs"

  parameter String fileName = "ss.mat";
  parameter Integer[nWin] winNLay = fill(3,nWin) "Number of window layers";
  parameter Integer nWin=3 "Number of windows";
  parameter Integer states = Bsize[1];
  parameter Integer inputs = Bsize[2];
  parameter Integer outputs = Dsize[1];
  Components.Interfaces.WinBus winBus[nWin](nLay=winNLay)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Continuous.StateSpace stateSpace(
    A=readMatrix(fileName=fileName, matrixName="A", rows=states, columns=  states),
    B=readMatrix(fileName=fileName, matrixName="B", rows=states, columns=  inputs),
    C=readMatrix(fileName=fileName, matrixName="C", rows=outputs, columns=states),
    D=readMatrix(fileName=fileName, matrixName="D", rows=outputs, columns=inputs),
    x_start=x_start)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));

protected
  final parameter Integer[2] Bsize = readMatrixSize(fileName=fileName, matrixName="B");
  final parameter Integer[2] Dsize = readMatrixSize(fileName=fileName, matrixName="D");

  final parameter Integer nSolBus = (sim.numAzi+1)*6
    "Total number of input signals in solBus";
  final parameter Integer[nWin] offWinCon = {nSolBus + 3 + sum(winNLay[1:i-1]) + 2*(i-1) for i in 1:nWin}
    "Offset of index for window connections";
  BoundaryConditions.WeatherData.Bus weaBus(numSolBus=sim.numAzi + 1)
    annotation (Placement(transformation(extent={{-42,4},{-22,24}})));
public
  Modelica.Blocks.Interfaces.RealOutput[stateSpace.nout] y
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  parameter Real x_start[states]=zeros(states)
    "Initial or guess values of states";
equation

  for i in 0:sim.numAzi loop
    connect(weaBus.solBus[1+i].iSolDir, stateSpace.u[1+i*6]);
    connect(weaBus.solBus[1+i].iSolDif, stateSpace.u[2+i*6]);
    connect(weaBus.solBus[1+i].angZen, stateSpace.u[3+i*6]);
    connect(weaBus.solBus[1+i].angAzi, stateSpace.u[4+i*6]);
    connect(weaBus.solBus[1+i].angInc, stateSpace.u[5+i*6]);
    connect(weaBus.solBus[1+i].Tenv,   stateSpace.u[6+i*6]);
  end for;
  connect(weaBus.Te, stateSpace.u[nSolBus+1]);
  connect(weaBus.Tdes, stateSpace.u[nSolBus+2]);
  connect(weaBus.hConExt, stateSpace.u[nSolBus+3]);

  for i in 1:nWin loop
    connect(winBus[i].AbsQFlow[1:winNLay[i]], stateSpace.u[(offWinCon[i]+1):(offWinCon[i]+winNLay[i])]);
    connect(winBus[i].iSolDir, stateSpace.u[(offWinCon[i]+winNLay[i])+1]);
    connect(winBus[i].iSolDif, stateSpace.u[(offWinCon[i]+winNLay[i])+2]);
  end for;

  connect(weaBus, sim.weaBus) annotation (Line(
      points={{-32,14},{-55.3,14},{-55.3,97.2},{-68.6,97.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(stateSpace.y, y) annotation (Line(
      points={{11,0},{104,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Text(
          extent={{-60,40},{60,0}},
          lineColor={0,0,0},
          textString="sx=Ax+Bu"),
        Text(
          extent={{-60,0},{60,-40}},
          lineColor={0,0,0},
          textString=" y=Cx+Du"),
        Line(points={{-100,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255})}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics),
    Documentation(revisions="<html>
<ul>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end StateSpace;
