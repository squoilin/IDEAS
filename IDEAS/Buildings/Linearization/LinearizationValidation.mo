within IDEAS.Buildings.Linearization;
model LinearizationValidation
  extends Modelica.Icons.Example;
  BaseClasses.LinCase900 linCase900_1 if enableExact.k
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
public
  inner SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-102,46},{-82,66}})));
protected
  Components.LinearizableWindow[3] win(
    final A={6,6,6},
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazing,
    each inc=IDEAS.Constants.Wall,
    each azi=IDEAS.Constants.South,
    redeclare replaceable IDEAS.Buildings.Components.Shading.None shaType,
    redeclare final parameter IDEAS.Buildings.Data.Frames.None fraType,
    each frac=0,
    each linearizeWindow=true,
    each linOut=true) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-67,10})));
public
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-8,-2},{-28,18}})));
  BaseClasses.StateSpace stateSpace(x_start=fill(293.15, stateSpace.states)) if enableLin.k
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

  Modelica.Blocks.Math.Add error(k2=-1) if enableLin.k and enableExact.k
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Sources.BooleanConstant enableExact(k=true)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.BooleanConstant enableLin(k=true)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
initial equation

  //remove initial equation when only enabling one of the two cases
  stateSpace.stateSpace.y[1] = linCase900_1.y;

equation
  connect(linCase900_1.weaBus1, sim.weaBus) annotation (Line(
      points={{0.2,33.4},{-50,33.4},{-50,78},{-90.6,78},{-90.6,63.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(win.winBus, linCase900_1.winBus) annotation (Line(
      points={{-61,15.2},{-61,25},{0.2,25}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  for i in 1:3 loop
  connect(win[i].weaBus, sim.weaBus) annotation (Line(
      points={{-77,2},{-78,2},{-78,63.2},{-90.6,63.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  end for;
  connect(const.y, win[1].Ctrl) annotation (Line(
      points={{-29,8},{-50,8},{-50,7},{-57,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, win[2].Ctrl) annotation (Line(
      points={{-29,8},{-50,8},{-50,7},{-57,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, win[3].Ctrl) annotation (Line(
      points={{-29,8},{-50,8},{-50,7},{-57,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stateSpace.winBus, win.winBus) annotation (Line(
      points={{0,-30},{-22,-30},{-22,-28},{-46,-28},{-46,15.2},{-61,15.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(error.u1, linCase900_1.y) annotation (Line(
      points={{38,16},{30,16},{30,28},{20.6,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(error.u2, stateSpace.y[1]) annotation (Line(
      points={{38,4},{28,4},{28,-30},{20.4,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    Documentation(revisions="<html>
<ul>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>Script for running validation:</p>
<pre>re=Modelica_LinearSystems2.ModelAnalysis.Linearize(&QUOT;IDEAS.Buildings.Linearization.BaseClasses.LinCase900&QUOT;);
writeMatrix(fileName=&QUOT;ss.mat&QUOT;,matrixName=&QUOT;A&QUOT;,matrix=re.A);
writeMatrix(fileName=&QUOT;ss.mat&QUOT;,matrixName=&QUOT;B&QUOT;,matrix=re.B, append=true);
writeMatrix(fileName=&QUOT;ss.mat&QUOT;,matrixName=&QUOT;C&QUOT;,matrix=re.C, append=true);
writeMatrix(fileName=&QUOT;ss.mat&QUOT;,matrixName=&QUOT;D&QUOT;,matrix=re.D, append=true);
simulateModel(&QUOT;IDEAS.Buildings.Linearization.LinearizationValidation&QUOT;, stopTime=1e+06, method=&QUOT;dassl&QUOT;, resultFile=&QUOT;LinearizationValidation&QUOT;);
createPlot(id=1,&nbsp;position={0,&nbsp;0,&nbsp;1211,&nbsp;619},&nbsp;y={&QUOT;stateSpace.y[1]&QUOT;,&nbsp;&QUOT;linCase900_1.y&QUOT;},&nbsp;range={0.0,&nbsp;1000000.0,&nbsp;272.0,&nbsp;294.0},&nbsp;grid=true,&nbsp;leftTitleType=1,&nbsp;bottomTitleType=1,&nbsp;colors={{0,0,255},&nbsp;{255,0,0}});


Make sure to enable output of protected variables.</pre>
</html>"),
    __Dymola_Commands,
    experiment(
      StopTime=1e+07,
      Tolerance=1e-06,
      __Dymola_Algorithm="Radau"),
    __Dymola_experimentSetupOutput);
end LinearizationValidation;
