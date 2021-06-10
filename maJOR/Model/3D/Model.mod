'# MWS Version: Version 2014.0 - Feb 24 2014 - ACIS 23.0.0 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 3 fmax = 14
'# created = '[VERSION]2014.0|23.0.0|20140224[/VERSION]


'@ use template: Antenna - Planar_4

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "NanoH"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "PikoF"
End With
'----------------------------------------------------------------------------
Plot.DrawBox True
With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mue "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With
' optimize mesh settings for planar structures
With Mesh
     .MergeThinPECLayerFixpoints "True"
     .RatioLimit "20"
     .AutomeshRefineAtPecLines "True", "6"
     .FPBAAvoidNonRegUnite "True"
     .ConsiderSpaceForLowerMeshLimit "False"
     .MinimumStepNumber "5"
     .AnisotropicCurvatureRefinement "True"
     .AnisotropicCurvatureRefinementFSM "True"
End With
With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "6"
End With
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With
' change mesh adaption scheme to energy
' 		(planar structures tend to store high energy
'     	 locally at edges rather than globally in volume)
MeshAdaption3D.SetAdaptionStrategy "Energy"
' switch on FD-TET setting for accurate farfields
FDSolver.ExtrudeOpenBC "True"
PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "PBA"
End With
'set the solver type
ChangeSolverType("HF Time Domain")

'@ set workplane properties

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With WCS
     .SetWorkplaneSize "100"
     .SetWorkplaneRaster "10"
     .SetWorkplaneAutoadjust "True"
     .SetWorkplaneSnap "True"
     .SetWorkplaneSnapRaster "0.1"
     .SetWorkplaneAutosnapFactor "0.01"
     .SetWorkplaneSnapAutoadjust "True"
End With

'@ activate local coordinates

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.ActivateWCS "local"

'@ define material: FR-4 (lossy)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Material
     .Reset
     .Name "FR-4 (lossy)"
     .Folder ""
.FrqType "all" 
.Type "Normal" 
.SetMaterialUnit "GHz", "mm"
.Epsilon "4.3" 
.Mue "1.0" 
.Kappa "0.0" 
.TanD "0.025" 
.TanDFreq "10.0" 
.TanDGiven "True" 
.TanDModel "ConstTanD" 
.KappaM "0.0" 
.TanDM "0.0" 
.TanDMFreq "0.0" 
.TanDMGiven "False" 
.TanDMModel "ConstKappa" 
.DispModelEps "None" 
.DispModelMue "None" 
.DispersiveFittingSchemeEps "General 1st" 
.DispersiveFittingSchemeMue "General 1st" 
.UseGeneralDispersionEps "False" 
.UseGeneralDispersionMue "False" 
.Rho "0.0" 
.ThermalType "Normal" 
.ThermalConductivity "0.3" 
.SetActiveMaterial "all" 
.Colour "0.94", "0.82", "0.76" 
.Wireframe "False" 
.Transparency "0" 
.Create
End With

'@ new component: component1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Component.New "component1"

'@ define brick: component1:substrate

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "substrate" 
     .Component "component1" 
     .Material "FR-4 (lossy)" 
     .Xrange "-Wx", "Wx" 
     .Yrange "-Lx", "Lx" 
     .Zrange "0", "h" 
     .Create
End With

'@ pick face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:substrate", "2"

'@ align wcs with face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ pick face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:substrate", "2"

'@ define material: Copper (annealed)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Material
     .Reset
     .Name "Copper (annealed)"
     .Folder ""
.FrqType "static" 
.Type "Normal" 
.SetMaterialUnit "Hz", "mm" 
.Epsilon "1" 
.Mue "1.0" 
.Kappa "5.8e+007" 
.TanD "0.0" 
.TanDFreq "0.0" 
.TanDGiven "False" 
.TanDModel "ConstTanD" 
.KappaM "0" 
.TanDM "0.0" 
.TanDMFreq "0.0" 
.TanDMGiven "False" 
.TanDMModel "ConstTanD" 
.DispModelEps "None" 
.DispModelMue "None" 
.DispersiveFittingSchemeEps "1st Order" 
.DispersiveFittingSchemeMue "1st Order" 
.UseGeneralDispersionEps "False" 
.UseGeneralDispersionMue "False" 
.FrqType "all" 
.Type "Lossy metal" 
.SetMaterialUnit "GHz", "mm" 
.Mue "1.0" 
.Kappa "5.8e+007" 
.Rho "8930.0" 
.ThermalType "Normal" 
.ThermalConductivity "401.0" 
.HeatCapacity "0.39" 
.MetabolicRate "0" 
.BloodFlow "0" 
.VoxelConvection "0" 
.MechanicsType "Isotropic" 
.YoungsModulus "120" 
.PoissonsRatio "0.33" 
.ThermalExpansionRate "17" 
.Colour "1", "1", "0" 
.Wireframe "False" 
.Reflection "False" 
.Allowoutline "True" 
.Transparentoutline "False" 
.Transparency "0" 
.Create
End With

'@ define extrude: component1:ground plane

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Extrude 
     .Reset 
     .Name "ground plane" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Mode "Picks" 
     .Height "0.1" 
     .Twist "0.0" 
     .Taper "0.0" 
     .UsePicksForHeight "False" 
     .DeleteBaseFaceSolid "False" 
     .ClearPickedFace "True" 
     .Create 
End With

'@ pick face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:substrate", "1"

'@ align wcs with face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ define brick: component1:patch

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "patch" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-Wx/2", "Wx/2" 
     .Yrange "-Lx/2", "Lx/2" 
     .Zrange "0", "0.1" 
     .Create
End With

'@ define material: Nickel

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Material
     .Reset
     .Name "Nickel"
     .Folder ""
.FrqType "all" 
.Type "Lossy metal" 
.SetMaterialUnit "GHz", "mm" 
.Mue "600" 
.Kappa "1.44e7" 
.Rho "8900" 
.ThermalType "Normal" 
.ThermalConductivity "91" 
.HeatCapacity "0.45" 
.MetabolicRate "0" 
.BloodFlow "0" 
.VoxelConvection "0" 
.MechanicsType "Isotropic" 
.YoungsModulus "207" 
.PoissonsRatio "0.31" 
.ThermalExpansionRate "13.1" 
.FrqType "static" 
.Type "Normal" 
.SetMaterialUnit "GHz", "mm" 
.Epsilon "1" 
.Mue "600" 
.Kappa "1.44e7" 
.TanD "0.0" 
.TanDFreq "0.0" 
.TanDGiven "False" 
.TanDModel "ConstTanD" 
.KappaM "0" 
.TanDM "0.0" 
.TanDMFreq "0.0" 
.TanDMGiven "False" 
.TanDMModel "ConstTanD" 
.DispModelEps "None" 
.DispModelMue "None" 
.DispersiveFittingSchemeEps "1st Order" 
.DispersiveFittingSchemeMue "1st Order" 
.UseGeneralDispersionEps "False" 
.UseGeneralDispersionMue "False" 
.Colour "0", "0.501961", "0.25098" 
.Wireframe "False" 
.Reflection "False" 
.Allowoutline "True" 
.Transparentoutline "False" 
.Transparency "0" 
.Create
End With

'@ define brick: component1:empty space

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "empty space" 
     .Component "component1" 
     .Material "Nickel" 
     .Xrange "-(8.7/2+1)", "(8.7/2+1)" 
     .Yrange "Lx/2-12.5", "Lx/2" 
     .Zrange "0", "0.1" 
     .Create
End With

'@ boolean subtract shapes: component1:patch, component1:empty space

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Solid 
     .Version 9
     .Subtract "component1:patch", "component1:empty space" 
     .Version 1
End With

'@ define brick: component1:micro strip

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "micro strip" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-8.7/2", "8.7/2" 
     .Yrange "Lx/2-12.5", "31.5+ Lx/2-12.5" 
     .Zrange "0", "0.1" 
     .Create
End With

'@ delete shape: component1:ground plane

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Delete "component1:ground plane"

'@ delete shape: component1:micro strip

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Delete "component1:micro strip"

'@ align wcs with face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.ForceNextPick 
Pick.PickFaceFromId "component1:substrate", "1" 
WCS.AlignWCSWithSelected "Face"

'@ delete shape: component1:substrate

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Delete "component1:substrate"

'@ define brick: component1:Sustrate

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "Sustrate" 
     .Component "component1" 
     .Material "FR-4 (lossy)" 
     .Xrange "-Lx", "Lx" 
     .Yrange "-Wx", "Wx" 
     .Zrange "0", "h" 
     .Create
End With

''@ boolean add shapes: component1:patch, component1:micro strip
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'With Solid 
'     .Version 9
'     .Add "component1:patch", "component1:micro strip" 
'     .Version 1
'End With
'
''@ clear picks
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'Pick.ClearAllPicks
'
''@ pick face
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'Pick.PickFaceFromId "component1:patch", "5"
'
''@ define port: 1
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'With Port 
'     .Reset 
'     .PortNumber "1" 
'     .Label "" 
'     .NumberOfModes "1" 
'     .AdjustPolarization "False" 
'     .PolarizationAngle "0.0" 
'     .ReferencePlaneDistance "0" 
'     .TextSize "50" 
'     .Coordinates "Picks" 
'     .Orientation "positive" 
'     .PortOnBound "True" 
'     .ClipPickedPortToBound "False" 
'     .Xrange "-4.35", "4.35" 
'     .Yrange "38", "38" 
'     .Zrange "4.5", "4.6" 
'     .XrangeAdd "3*8.7", "3*8.7" 
'     .YrangeAdd "0.0", "0.0" 
'     .ZrangeAdd " h+0.1", "4*h" 
'     .SingleEnded "False" 
'     .Create 
'End With
'
''@ define frequency range
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'Solver.FrequencyRange "0", "2"
'
''@ define monitor: h-field (f=1.8)
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'With Monitor 
'     .Reset 
'     .Name "h-field (f=1.8)" 
'     .Dimension "Volume" 
'     .Domain "Frequency" 
'     .FieldType "Hfield" 
'     .Frequency "1.8" 
'     .UseSubvolume "False" 
'     .SetSubvolume  "-125.9481145",  "125.9481145",  "-112.9481145",  "112.9481145",  "-75.0481145",  "97.5481145" 
'     .Create 
'End With
'
''@ define farfield monitor: farfield (f=1.8)
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'With Monitor 
'     .Reset 
'     .Name "farfield (f=1.8)" 
'     .Domain "Frequency" 
'     .FieldType "Farfield" 
'     .Frequency "1.8" 
'     .UseSubvolume "False" 
'     .ExportFarfieldSource "False" 
'     .SetSubvolume  "-125.9481145",  "125.9481145",  "-112.9481145",  "112.9481145",  "-75.0481145",  "97.5481145" 
'     .Create 
'End With
'
''@ define time domain solver parameters
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'Mesh.SetCreator "High Frequency" 
'With Solver 
'     .Method "Hexahedral"
'     .CalculationType "TD-S"
'     .StimulationPort "All"
'     .StimulationMode "All"
'     .SteadyStateLimit "-30.0"
'     .MeshAdaption "False"
'     .AutoNormImpedance "True"
'     .NormingImpedance "50"
'     .CalculateModesOnly "False"
'     .SParaSymmetry "False"
'     .StoreTDResultsInCache  "False"
'     .FullDeembedding "False"
'     .SuperimposePLWExcitation "False"
'     .UseSensitivityAnalysis "False"
'End With
'
''@ set pba mesh type
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'Mesh.MeshType "PBA"
'
''@ define frequency range
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'Solver.FrequencyRange "1", "2.5"
'
''@ set pba mesh type
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'Mesh.MeshType "PBA"
'
''@ farfield plot options
'
''[VERSION]2014.0|23.0.0|20140224[/VERSION]
'With FarfieldPlot 
'     .Plottype "3D" 
'     .Vary "angle1" 
'     .Theta "90" 
'     .Phi "90" 
'     .Step "5" 
'     .Step2 "5" 
'     .SetLockSteps "True" 
'     .SetPlotRangeOnly "False" 
'     .SetThetaStart "0" 
'     .SetThetaEnd "180" 
'     .SetPhiStart "0" 
'     .SetPhiEnd "360" 
'     .SetTheta360 "False" 
'     .SymmetricRange "False" 
'     .SetTimeDomainFF "False" 
'     .SetFrequency "1.8" 
'     .SetTime "0" 
'     .SetColorByValue "True" 
'     .DrawStepLines "False" 
'     .DrawIsoLongitudeLatitudeLines "False" 
'     .ShowStructure "False" 
'     .SetStructureTransparent "False" 
'     .SetFarfieldTransparent "False" 
'     .SetSpecials "enablepolarextralines" 
'     .SetPlotMode "Gain" 
'     .Distance "1" 
'     .UseFarfieldApproximation "True" 
'     .SetScaleLinear "False" 
'     .SetLogRange "40" 
'     .SetLogNorm "0" 
'     .DBUnit "0" 
'     .EnableFixPlotMaximum "False" 
'     .SetFixPlotMaximumValue "1" 
'     .SetInverseAxialRatio "False" 
'     .SetAxesType "user" 
'     .SetAnntenaType "unknown" 
'     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
'     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
'     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
'     .SetCoordinateSystemType "spherical" 
'     .SetAutomaticCoordinateSystem "True" 
'     .SetPolarizationType "Linear" 
'     .SlantAngle 0.000000e+000 
'     .Origin "bbox" 
'     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
'     .SetUserDecouplingPlane "False" 
'     .UseDecouplingPlane "False" 
'     .DecouplingPlaneAxis "X" 
'     .DecouplingPlanePosition "0.000000e+000" 
'     .LossyGround "False" 
'     .GroundEpsilon "1" 
'     .GroundKappa "0" 
'     .EnablePhaseCenterCalculation "False" 
'     .SetPhaseCenterAngularLimit "3.000000e+001" 
'     .SetPhaseCenterComponent "boresight" 
'     .SetPhaseCenterPlane "both" 
'     .ShowPhaseCenter "True" 
'     .StoreSettings
'End With
'
'@ align wcs with point

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickEndpointFromId "component1:Sustrate", "2" 
WCS.AlignWCSWithSelectedPoint

'@ define brick: component1:ground

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "ground" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-(Wx-1.1/2-0.23333)", "0" 
     .Yrange "-7", "0" 
     .Zrange "0", "0.1" 
     .Create
End With

'@ align wcs with point

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickEndpointFromId "component1:Sustrate", "3" 
WCS.AlignWCSWithSelectedPoint

'@ define brick: component1:Ground r

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "Ground r" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "0", "Wx-1.1/2-0.23333" 
     .Yrange "-7", "0" 
     .Zrange "0", "0.1" 
     .Create
End With

'@ boolean add shapes: component1:Ground r, component1:ground

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Solid 
     .Version 9
     .Add "component1:Ground r", "component1:ground" 
     .Version 1
End With

'@ rename block: component1:Ground r to: component1:Ground

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Rename "component1:Ground r", "Ground"

'@ move wcs

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.MoveWCS "local", "Wx", "0.0", "0.0"

'@ define brick: component1:solid1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-1.1/2", "1.1/2" 
     .Yrange "-7", "0" 
     .Zrange "0", "0.1" 
     .Create
End With

'@ move wcs

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.MoveWCS "local", "0.0", "-7", "0.0"

'@ define curve polygon: curve1:polygon1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "1.1/2", "0" 
     .RLine "8", "-6.5" 
     .RLine "-8-1.1/2", "-6" 
     .RLine "-8-1.1/2", "6" 
     .RLine "8", "6.5" 
     .RLine "1.1", "0" 
     .Create 
End With

'@ define extrudeprofile: component1:solid2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Thickness "-0.1" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:polygon1" 
     .Create
End With

'@ boolean add shapes: component1:solid2, component1:solid1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Solid 
     .Version 9
     .Add "component1:solid2", "component1:solid1" 
     .Version 1
End With

'@ align wcs with face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.ForceNextPick 
Pick.PickFaceFromId "component1:solid2", "12" 
WCS.AlignWCSWithSelected "Face"

'@ pick face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:solid2", "5"

'@ define port: 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "True" 
     .ClipPickedPortToBound "False" 
     .Xrange "-0.5", "0.5" 
     .Yrange "9", "9" 
     .Zrange "3.2", "3.3" 
     .XrangeAdd "3*1.1", "3*1.1" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "h", "4*h" 
     .SingleEnded "False" 
     .Create 
End With

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "2", "11"

'@ define monitor: h-field (f=6.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=6.5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .Frequency "6.5" 
     .UseSubvolume "False" 
     .SetSubvolume  "-18.530479153846",  "18.530479153846",  "-20.530479153846",  "20.530479153846",  "-9.9304791538462",  "21.230479153846" 
     .Create 
End With

'@ define farfield monitor: farfield (f=6.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=6.5)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .Frequency "6.5" 
     .UseSubvolume "False" 
     .ExportFarfieldSource "False" 
     .SetSubvolume  "-18.530479153846",  "18.530479153846",  "-20.530479153846",  "20.530479153846",  "-9.9304791538462",  "21.230479153846" 
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-30.0"
     .MeshAdaption "False"
     .AutoNormImpedance "True"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ rename block: component1:solid2 to: component1:Patch

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Rename "component1:solid2", "Patch"

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ activate global coordinates

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.ActivateWCS "global"

'@ set parametersweep options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
    .SetSimulationType "Transient" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:Hg

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "7", "1", "10", "11", "False" 
End With

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "4", "14"

'@ align wcs with edge and face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:Ground", "1" 
Pick.PickEdgeFromId "component1:Patch", "2", "2" 
WCS.AlignWCSWithSelected "EdgeAndFace"

'@ activate global coordinates

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.ActivateWCS "global"

'@ align wcs with edge and face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:Patch", "12" 
Pick.PickEdgeFromId "component1:Patch", "2", "2" 
WCS.AlignWCSWithSelected "EdgeAndFace"

'@ edit parsweep parameter: Sequence 1:R

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "R" 
     .AddParameter_Samples "Sequence 1", "0.1", "0", "2", "10", "False" 
End With

'@ define cylinder: component1:Circle

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Cylinder 
     .Reset 
     .Name "Circle" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "0.1" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-0.1", "0" 
     .Xcenter "0" 
     .Ycenter "7+6+6.5" 
     .Segments "0" 
     .Create 
End With

'@ boolean add shapes: component1:Patch, component1:Circle

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Solid 
     .Version 9
     .Add "component1:Patch", "component1:Circle" 
     .Version 1
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:R

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "0.1", "0", "2", "1", "False" 
End With

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "6", "16"

'@ edit parsweep parameter: Sequence 1:R

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "R" 
     .AddParameter_Samples "Sequence 1", "0.1", "0", "1.5", "6", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:X

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "8", "0", "6", "10", "False" 
End With

'@ delete monitor: farfield (f=6.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Monitor.Delete "farfield (f=6.5)"

'@ delete monitor: h-field (f=6.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Monitor.Delete "h-field (f=6.5)"

'@ define farfield monitor: farfield (broadband)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (broadband)" 
     .Domain "Time" 
     .Accuracy "1e-3" 
     .FrequencySamples "210" 
     .FieldType "Farfield" 
     .Frequency "11" 
     .TransientFarfield "False" 
     .ExportFarfieldSource "False" 
     .Create 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ define time domain solver parameters

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-60"
     .MeshAdaption "False"
     .AutoNormImpedance "True"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:h

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "h", "0.5", "3", "10", "False" 
End With

'@ delete parsweep parameter: Sequence 1:h

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "h" 
End With

'@ add parsweep parameter: Sequence 1:l

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Lx", "6", "9", "6", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 2" 
End With

'@ delete parsweep sequence: Sequence 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 2" 
End With

'@ add parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6", "0.1", "4", "1", "False" 
End With

'@ add parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6.5", "0.1", "3", "8", "False" 
End With

'@ edit parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y1" 
     .AddParameter_Samples "Sequence 1", "6", "0.1", "4", "8", "False" 
End With

'@ delete parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y1" 
End With

'@ edit parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y" 
     .AddParameter_Samples "Sequence 1", "6.5", "3", "5", "8", "False" 
End With

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "1", "12"

'@ delete parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y" 
End With

'@ add parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6", "3", "5", "8", "False" 
End With

'@ delete parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y1" 
End With

'@ add parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6", "3", "5", "4", "False" 
End With

'@ delete parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y1" 
End With

'@ add parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6.5", "3", "5", "1", "False" 
End With

'@ edit parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y" 
     .AddParameter_Samples "Sequence 1", "6.5", "3", "5", "8", "False" 
End With

'@ delete parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y" 
End With

'@ add parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6", "3.5", "5", "5", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "1", "16"

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "3", "14"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:G

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "0.23333", "0.1", "2", "10", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:w

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Wx", "6", "9", "10", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "12" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ add parsweep parameter: Sequence 1:R

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "0.1", "0.1", "2", "10", "False" 
End With

'@ delete parsweep parameter: Sequence 1:w

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "w" 
End With

'@ delete parsweep parameter: Sequence 1:R

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "R" 
End With

'@ add parsweep parameter: Sequence 1:X

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "8", "2", "5", "20", "False" 
End With

'@ define monitor: e-field (f=8.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=8.5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .Frequency "8.5" 
     .UseSubvolume "False" 
     .SetSubvolume  "-15.817425235294",  "15.817425235294",  "-17.817425235294",  "17.817425235294",  "-7.2174252352941",  "18.517425235294" 
     .Create 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ edit parsweep parameter: Sequence 1:X

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "X" 
     .AddParameter_Samples "Sequence 1", "8", "4", "6", "20", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:X

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "8", "6", "6.5", "5", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:w

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Wx", "6.8", "8", "10", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:l

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Lx", "8", "10", "20", "False" 
End With

'@ align wcs with point

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickEndpointFromId "component1:Patch", "11" 
WCS.AlignWCSWithSelectedPoint

'@ activate global coordinates

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.ActivateWCS "global"

'@ align wcs with edge and face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:Patch", "15" 
Pick.PickEdgeFromId "component1:Patch", "4", "4" 
WCS.AlignWCSWithSelected "EdgeAndFace"

'@ define cylinder: component1:solid1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "2" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-0.1", "0" 
     .Xcenter "1.1/2+8" 
     .Ycenter "7+6.5" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:solid2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "2" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-0.1", "0" 
     .Xcenter "-(8+1.1/2)" 
     .Ycenter "7+6.5" 
     .Segments "0" 
     .Create 
End With

'@ boolean subtract shapes: component1:Patch, component1:solid1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Solid 
     .Version 9
     .Subtract "component1:Patch", "component1:solid1" 
     .Version 1
End With

'@ boolean subtract shapes: component1:Patch, component1:solid2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Solid 
     .Version 9
     .Subtract "component1:Patch", "component1:solid2" 
     .Version 1
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:r1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "2", "0.1", "2", "10", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6", "4", "5", "1", "False" 
End With

'@ edit parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y1" 
     .AddParameter_Samples "Sequence 1", "6", "4", "5", "5", "False" 
End With

'@ add parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6.5", "4", "5", "5", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:l

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Lx", "9.789", "11", "3", "False" 
End With

'@ add parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6.5", "5", "6", "3", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6.5", "6", "6.5", "3", "False" 
End With

'@ edit parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y" 
     .AddParameter_Samples "Sequence 1", "6.5", "6", "6.5", "2", "False" 
End With

'@ add parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6", "6", "6.5", "2", "False" 
End With

'@ add parsweep parameter: Sequence 1:X

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "8", "6", "7", "3", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:X

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "8", "7", "8", "4", "False" 
End With

'@ add parsweep parameter: Sequence 1:r1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "2", "2", "4", "4", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:G

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "0.23333", "0.1", "0.2", "4", "False" 
End With

'@ edit parsweep parameter: Sequence 1:G

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "G" 
     .AddParameter_Samples "Sequence 1", "0.23333", "0.1", "0.3", "4", "False" 
End With

'@ add parsweep parameter: Sequence 1:Hg

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "7", "4", "7", "1", "False" 
End With

'@ edit parsweep parameter: Sequence 1:Hg

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Hg" 
     .AddParameter_Samples "Sequence 1", "7", "4", "7", "5", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:R

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "0.1", "0.1", "1.3", "6", "False" 
End With

'@ add parsweep parameter: Sequence 1:Sw

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "1.1", "0.5", "1.1", "3", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:Y

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6.5", "6.5", "7", "4", "False" 
End With

'@ add parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "6", "6", "6.7", "4", "False" 
End With

'@ edit parsweep parameter: Sequence 1:Y1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Y1" 
     .AddParameter_Samples "Sequence 1", "6", "6", "6.7", "5", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "12" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ delete shape: component1:Patch

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Delete "component1:Patch"

'@ delete shape: component1:Ground

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Delete "component1:Ground"

'@ delete shape: component1:patch

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Delete "component1:patch"

'@ align wcs with edge and face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:Sustrate", "1" 
Pick.PickEdgeFromId "component1:Sustrate", "2", "2" 
WCS.AlignWCSWithSelected "EdgeAndFace"

'@ define curve polygon: curve1:polygon1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "-Lw/2", "0" 
     .RLine "0", "Ll" 
     .RLine "-(C-Lw)/2", "0" 
     .RLine "0", "d" 
     .RLine "-(W-C)/2", "0" 
     .RLine "0", "L" 
     .RLine "W", "0" 
     .RLine "0", "-L" 
     .RLine "-(W-C)/2", "0" 
     .RLine "0", "-d" 
     .RLine "-(C-Lw)/2", "0" 
     .RLine "0", "-Ll" 
     .RLine "-Lw", "0" 
     .Create 
End With

'@ define extrudeprofile: component1:Patch

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "Patch" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Thickness "-t" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:polygon1" 
     .Create
End With

'@ align wcs with edge and face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:Patch", "14" 
Pick.PickEdgeFromId "component1:Patch", "22", "16" 
WCS.AlignWCSWithSelected "EdgeAndFace"

'@ align wcs with point

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickEndpointFromId "component1:Patch", "14" 
WCS.AlignWCSWithSelectedPoint

'@ define curve polygon: curve1:polygon1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "w", "0" 
     .LineTo "0", "L" 
     .LineTo "0", "0" 
     .LineTo "w", "0" 
     .Create 
End With

'@ define extrudeprofile: component1:Traingle

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "Traingle" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Thickness "-t" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:polygon1" 
     .Create
End With

'@ delete shape: component1:Traingle

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Delete "component1:Traingle"

'@ define curve polygon: curve1:polygon1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "W1", "0" 
     .LineTo "0", "L1" 
     .LineTo "0", "0" 
     .LineTo "W1", "0" 
     .Create 
End With

'@ define extrudeprofile: component1:Traingle 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "Traingle 1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Thickness "-t" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:polygon1" 
     .Create
End With

'@ delete shape: component1:Traingle 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solid.Delete "component1:Traingle 1"

'@ align wcs with point

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickEndpointFromId "component1:Patch", "11" 
WCS.AlignWCSWithSelectedPoint

'@ define curve polygon: curve1:polygon1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "-W1", "0" 
     .LineTo "0", "L1" 
     .LineTo "0", "0" 
     .LineTo "-W1", "0" 
     .Create 
End With

'@ define extrudeprofile: component1:solid1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Thickness "-t" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:polygon1" 
     .Create
End With

'@ boolean subtract shapes: component1:Patch, component1:solid1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Solid 
     .Version 9
     .Subtract "component1:Patch", "component1:solid1" 
     .Version 1
End With

'@ align wcs with point

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickEndpointFromId "component1:Patch", "13" 
WCS.AlignWCSWithSelectedPoint

'@ define curve polygon: curve1:polygon1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "W2", "0" 
     .LineTo "0", "-L2" 
     .LineTo "0", "0" 
     .LineTo "W2", "0" 
     .Create 
End With

'@ define extrudeprofile: component1:solid1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Thickness "-t" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:polygon1" 
     .Create
End With

'@ boolean subtract shapes: component1:Patch, component1:solid1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Solid 
     .Version 9
     .Subtract "component1:Patch", "component1:solid1" 
     .Version 1
End With

'@ align wcs with edge and face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:Patch", "24" 
Pick.PickEdgeFromId "component1:Patch", "50", "33" 
WCS.AlignWCSWithSelected "EdgeAndFace"

'@ rotate wcs

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.RotateWCS "v", "180.00"

'@ define brick: component1:Ground 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Brick
     .Reset 
     .Name "Ground 1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "((Lw/2)+gp)", "(G1w+(Lw/2)+gp)" 
     .Yrange "0", "G1l" 
     .Zrange "0", "t" 
     .Create
End With

'@ rotate wcs

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
WCS.RotateWCS "w", "180.00"

'@ align wcs with edge and face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:Patch", "24" 
Pick.PickEdgeFromId "component1:Patch", "50", "33" 
WCS.AlignWCSWithSelected "EdgeAndFace"

'@ define curve polygon: curve1:Ground 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Polygon 
     .Reset 
     .Name "Ground 2" 
     .Curve "curve1" 
     .Point "Lw/2 + gp", "0" 
     .RLine "Gr", "0" 
     .RLine "0", "2*Wx" 
     .RLine "-Ly", "0" 
     .RLine "0", "-x1" 
     .RLine "Ly-x1", "0" 
     .RLine "0", "-(2*Wx-G1l-x1)" 
     .RLine "-(Gr-x1)", "0" 
     .RLine "0", "-G1l" 
     .Create 
End With

'@ define extrudeprofile: component1:Ground 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ExtrudeCurve
     .Reset 
     .Name "Ground 2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Thickness "-t" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .Curve "curve1:Ground 2" 
     .Create
End With

'@ pick face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.PickFaceFromId "component1:Patch", "21"

'@ define port: 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "55" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "-0.75", "0.75" 
     .Yrange "15", "15" 
     .Zrange "1.6", "1.8" 
     .XrangeAdd "3*Lw", "3*Lw" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "h", "4*h + t" 
     .SingleEnded "False" 
     .Create 
End With

'@ delete port: port1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Port.Delete "1"

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "3", "18"

'@ define farfield monitor: farfield (f=10.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=10.5)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .Frequency "10.5" 
     .UseSubvolume "False" 
     .ExportFarfieldSource "False" 
     .SetSubvolume  "-24.637915666667",  "24.637915666667",  "-22.137915666667",  "22.137915666667",  "-6.3379156666667",  "12.337915666667" 
     .Create 
End With

'@ define monitor: e-field (f=10.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=10.5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .Frequency "10.5" 
     .UseSubvolume "False" 
     .SetSubvolume  "-24.637915666667",  "24.637915666667",  "-22.137915666667",  "22.137915666667",  "-6.3379156666667",  "12.337915666667" 
     .Create 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "18" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "18" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "1", "11"

'@ add parsweep parameter: Sequence 1:Lx

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Lx", "12.5", "17", "5", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:L1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "L1", "10", "12.9", "4", "False" 
End With

'@ add parsweep parameter: Sequence 1:W1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "W1", "10", "13.3", "4", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:C

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "C", "1.5", "4", "5", "False" 
End With

'@ add parsweep parameter: Sequence 1:d

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "d", "1", "4", "5", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:Gr

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Gr", "5", "12", "7", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:L

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "L", "11", "15", "5", "False" 
End With

'@ add parsweep parameter: Sequence 1:W

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "W", "11", "15", "5", "False" 
End With

'@ define farfield monitor: farfield (f=6)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=6)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .Frequency "6" 
     .UseSubvolume "False" 
     .ExportFarfieldSource "False" 
     .SetSubvolume  "-29.491352416667",  "29.491352416667",  "-27.491352416667",  "27.491352416667",  "-11.691352416667",  "17.491352416667" 
     .Create 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "11" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:G1l

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "G1l", "1", "8", "8", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:Wx

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Wx", "12", "16", "8", "False" 
End With

'@ delete monitor: e-field (f=10.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Monitor.Delete "e-field (f=10.5)"

'@ delete monitor: e-field (f=8.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Monitor.Delete "e-field (f=8.5)"

'@ delete monitor: farfield (f=10.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Monitor.Delete "farfield (f=10.5)"

'@ delete monitor: farfield (f=6)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Monitor.Delete "farfield (f=6)"

'@ delete monitor: farfield (broadband)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Monitor.Delete "farfield (broadband)"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "11" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ define farfield monitor: farfield (f=6)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=6)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .Frequency "6" 
     .UseSubvolume "False" 
     .ExportFarfieldSource "False" 
     .SetSubvolume  "-29.491352416667",  "29.491352416667",  "-26.205638130951",  "30.777066702383",  "1.9086475833333",  "31.091352416667" 
     .Create 
End With

'@ define frequency range

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Solver.FrequencyRange "3", "14"

'@ edit parsweep parameter: Sequence 1:Wx

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Wx" 
     .AddParameter_Samples "Sequence 1", "Wx", "12.4", "13.5", "10", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "11" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "11" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 2" 
End With

'@ delete parsweep sequence: Sequence 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 2" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:Ly

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Ly", "5", "25", "20", "False" 
End With

'@ edit parsweep parameter: Sequence 1:Ly

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Ly" 
     .AddParameter_Samples "Sequence 1", "Ly", "23", "30", "15", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:L1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "L1", "1", "14.5", "15", "False" 
End With

'@ edit parsweep parameter: Sequence 1:L1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "L1" 
     .AddParameter_Samples "Sequence 1", "L1", "7", "14.5", "5", "False" 
End With

'@ add parsweep sequence: Sequence 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 2" 
End With

'@ add parsweep parameter: Sequence 1:W1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "W1", "1", "12.5", "5", "False" 
End With

'@ delete parsweep sequence: Sequence 2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 2" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:L1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "L1", "8.875", "10.7", "10", "False" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:Ll

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "Ll", "5.1", "6.2", "5", "False" 
End With

'@ edit parsweep parameter: Sequence 1:Ll

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "Ll" 
     .AddParameter_Samples "Sequence 1", "Ll", "5.1", "6.1", "5", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ delete parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ add parsweep parameter: Sequence 1:L2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "L2", "0", "6", "6", "False" 
End With

'@ add parsweep parameter: Sequence 1:W2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "W2", "0", "12.5", "10", "False" 
End With

'@ edit parsweep parameter: Sequence 1:W2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "W2" 
     .AddParameter_Samples "Sequence 1", "W2", "0", "12.5", "5", "False" 
End With

'@ edit parsweep parameter: Sequence 1:L2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "L2" 
     .AddParameter_Samples "Sequence 1", "L2", "0", "6", "5", "False" 
End With

'@ edit parsweep parameter: Sequence 1:W2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "W2" 
     .AddParameter_Samples "Sequence 1", "W2", "0", "6", "5", "False" 
End With

'@ edit parsweep parameter: Sequence 1:L2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "L2" 
     .AddParameter_Samples "Sequence 1", "L2", "0", "12.5", "5", "False" 
End With

'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ edit parsweep parameter: Sequence 1:L2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "L2" 
     .AddParameter_Samples "Sequence 1", "L2", "6.25", "7.4", "4", "False" 
End With

'@ edit parsweep parameter: Sequence 1:W2

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "W2" 
     .AddParameter_Samples "Sequence 1", "W2", "3", "5", "5", "False" 
End With

'@ align wcs with face

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Pick.ForceNextPick 
Pick.PickFaceFromId "component1:Patch", "24" 
WCS.AlignWCSWithSelected "Face"

'@ define farfield monitor: farfield (f=8.5)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=8.5)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .Frequency "8.5" 
     .UseSubvolume "False" 
     .ExportFarfieldSource "False" 
     .SetSubvolume  "-25.817425235294",  "25.817425235294",  "-21.457425235294",  "21.457425235294",  "-8.0174252352941",  "13.817425235294" 
     .Create 
End With 


'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "11" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With 


'@ delete monitor: farfield (f=6)

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Monitor.Delete "farfield (f=6)" 


'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "11" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Gain" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With 


'@ set pba mesh type

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
Mesh.MeshType "PBA"

'@ farfield plot options

'[VERSION]2014.0|23.0.0|20140224[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "11" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAnntenaType "unknown" 
     .Phistart "1.000000e+000", "0.000000e+000", "0.000000e+000" 
     .Thetastart "0.000000e+000", "0.000000e+000", "1.000000e+000" 
     .PolarizationVector "0.000000e+000", "1.000000e+000", "0.000000e+000" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+000 
     .Origin "bbox" 
     .Userorigin "0.000000e+000", "0.000000e+000", "0.000000e+000" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+000" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+001" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .StoreSettings
End With 


